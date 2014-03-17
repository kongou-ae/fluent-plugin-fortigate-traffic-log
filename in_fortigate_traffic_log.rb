class FortgateTrafficLog < Fluent::TailInput
  Fluent::Plugin.register_input('fortigate-traffic-log', self)

  # Override 'configure_parser(conf)' method.
  # You can get config parameters in this method.
  def configure_parser(conf)
    @time_format = conf['time_format'] || '%Y-%m-%d %H:%M:%S'
  end

  # Override 'parse_line(line)' method that returns time and record.
  def parse_line(line)
    # ログを,で分割して配列に格納する
    elements = line.split(",")

    # dateとtimeを結合して、実際の値を正規表現で抽出する
    tmp = "#{elements[0]},#{elements[1]}"
    tmp =~ /.+date=(.+),time=(.+)/
    tmp_date = $1

    # timeの中に含まれる半角スペースを除去する。$
    tmp_time = $2.gsub(/(\s)+/,'')

    # 抽出した値を一つにまとめて、timeオブジェクト経由でunixtimeにする$
    time = "#{tmp_date} #{tmp_time}"
    time = Time.strptime(time, @time_format).to_i

    # 処理が終了したので、配列から先頭2つを削除$
    elements.shift(2)

    # トラフィックログの処理
    record = {}
    while k = elements.shift
      k =~ /(.+)=(.+)/
      record[$1] = $2
    end

    return time, record
  end
end
