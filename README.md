# fluent-plugin-fortigate-traffic-log

FluentのTailインプットプラグインパーサーです。FortiGateから受信したsyslogをパースします。  
※rsyslogd + FortiGate-50B + OS4.0 MR3 Patch 14で動作確認を行っています。

### FortiGate's traffic log + rsyslog
    Mar 17 19:41:47 153.16.66.197 date=2014-03-17,time=19: 41:46,devname=FGT50Bxxxxxxxxxx,device_id=FGT50Bxxxxxxxxxx,log_id=0021000002,type=traffic,subtype=allowed,pri=notice,vd=root,src=109.171.83.127,src_port=45040,src_int="wan1",dst=153.16.xx.xx,dst_port=80,dst_int="VLAN-200",SN=3945,status=accept,policyid=16,dst_country="United States",src_country="Russian Federation",dir_disp=org,tran_disp=dnat,tran_ip=192.168.200.1,tran_port=80,service=HTTP,proto=6,duration=121,sent=60,rcvd=88,sent_pkt=1,rcvd_pkt=1

### result of parse
    1395052906
    {"devname"=>"FGT50B3G08625936", "device_id"=>"FGT50B3G08625936", "log_id"=>"0021000002", "type"=>"traffic", "subtype"=>"allowed", "pri"=>"notice", "vd"=>"root", "src"=>"109.171.83.127", "src_port"=>"45040", "src_int"=>"\"wan1\"", "dst"=>"153.16.66.201", "dst_port"=>"80", "dst_int"=>"\"VLAN-200\"", "SN"=>"3945", "status"=>"accept", "policyid"=>"16", "dst_country"=>"\"United States\"", "src_country"=>"\"Russian Federation\"", "dir_disp"=>"org", "tran_disp"=>"dnat", "tran_ip"=>"192.168.200.1", "tran_port"=>"80", "service"=>"HTTP", "proto"=>"6", "duration"=>"121", "sent"=>"60", "rcvd"=>"88", "sent_pkt"=>"1", "rcvd_pkt"=>"1"}


## Installation

1. FortiGateにsyslogの設定をしてください。(CSVフォーマットを有効にしてください)
2. in_fortigate_traffic_log.rbを/etc/fluent/plugin配下に設置してください

## Fluent's Configuration

    <source>
       type fortigate-traffic-log
       path /path/to/your/syslogfile
       pos_file /path/to/your/posfile
       tag yourtag
       time_format %Y-%m-%d %H:%M:%S
    </source>

