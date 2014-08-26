class FortgateTrafficLog < Fluent::TailInput
  Fluent::Plugin.register_input('fortigate-traffic-log', self)

  # Override 'configure_parser(conf)' method.
  # You can get config parameters in this method.
  def configure_parser(conf)
    @time_format = conf['time_format'] || '%Y-%m-%d %H:%M:%S'
  end

  # Override 'parse_line(line)' method that returns time and record.
  def parse_line(line)
    # スペースを含む要素を配列に格納する
    include_space = Array['dst_country','src_country','dstcountry','srccountry']
    # トラフィックログのみを処理対象とする
    if /.*type=traffic.*/ =~ line
      # メモリログの場合の個別処理
      if /devname/ !~ line
        # スペースを含む要素を一つずつ処理
        for i in include_space do
          # スペースを含む要素があれば処理
          if /#{i}/ =~ line
            # スペース付きの国名を抽出
            /#{i}="(.*?)"/ =~ line 
            country_name = $1
            # 国名に空白が含まれているかチェック
            if /.*\s.*/ =~ country_name
              # スペースが含まれている場合は、スペース削除済みの国名を用意する
              new_country_name = country_name.gsub(/\s/,'')
              # スペース削除済みの国名で、元々の国名を置換
              line.gsub!("\"#{country_name}\"", "\"#{new_country_name}\"")
            end
          end
        end
        # スペースの削除が終了したので、スペースを,に置換し、syslogと同じフォーマットにする
        line.gsub!(/\s/,',')
      end

      # ログを,で分割して配列に格納する
      elements = line.split(",")

      # syslog個別の処理
      if /devname/ =~ line
        # syslogの先頭と配列の1目を結合
        tmp = "#{elements[0]},#{elements[1]}"
        # 結合したものから、日時を抽出
        tmp =~ /.+date=(.+),time=(.+)/
        tmp_date = $1
        tmp_time = $2

        if /\s/ =~ tmp_time
          # timeの中に含まれる半角スペースを除去する。
          tmp_time.gsub!(/(\s)+/,'')
        end

        # 抽出した値を一つにまとめて、timeオブジェクト経由でunixtimeにする
        time = "#{tmp_date} #{tmp_time}"
      else
        time = "#{elements[0]} #{elements[1]}"
      end

      time = Time.strptime(time, @time_format).to_i
      # 処理が終了したので、配列から先頭2つを削除
      elements.shift(2)

      record = {}
      while k = elements.shift
        k =~ /(.+)=(.+)/
        record[$1] = $2
      end

      return time, record
    end
  end
end
