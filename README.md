# Fluent::Plugin::Fortigate::Traffic::Log

FortiGateから受信したsyslogをパースする、FluentのTailインプットプラグインパーサーです。
※OS4.0 MR3 Patch 14で動作確認を行っています。

## Installation

1. FortiGateにsyslogの設定をしてください。(CSVフォーマットを有効にしてください)
2. in_fortigate_traffic_log.rbを/etc/fluent/plugin配下に設置してください

## Fluent's Configuration

    <source>
       type fortigate-traffic-log
       path /path/to/your/logfile
       pos_file /path/to/your/posfile
       tag yourtag
       time_format %Y-%m-%d %H:%M:%S
    </source>

