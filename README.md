# fluent-plugin-fortigate-traffic-log

## Overview

This is the input plugin of fluent for parsing the traffic log of fortigate.

if you use [uken/fluent-plugin-elasticsearch](https://github.com/uken/fluent-plugin-elasticsearch), [elasticsearch](http://www.elasticsearch.org/) and [kibana](http://www.elasticsearch.org/overview/kibana/) , you can easily view and analyze the traffic log.

This plugin supports both syslog and local log.

## Demo

### FortiGate's traffic log (receive by   rsyslog)
    Mar 17 19:41:47 153.16.66.197 date=2014-03-17,time=19: 41:46,devname=FGT50Bxxxxxxxxxx,device_id=FGT50Bxxxxxxxxxx,log_id=0021000002,type=traffic,subtype=allowed,pri=notice,vd=root,src=109.171.83.127,src_port=45040,src_int="wan1",dst=153.16.xx.xx,dst_port=80,dst_int="VLAN-200",SN=3945,status=accept,policyid=16,dst_country="United States",src_country="Russian Federation",dir_disp=org,tran_disp=dnat,tran_ip=192.168.200.1,tran_port=80,service=HTTP,proto=6,duration=121,sent=60,rcvd=88,sent_pkt=1,rcvd_pkt=1

### Result(Time&record)
    1395052906
    {"devname"=>"FGT50Bxxxxxxxxxx", "device_id"=>"FGT50Bxxxxxxxxxx", "log_id"=>"0021000002", "type"=>"traffic", "subtype"=>"allowed", "pri"=>"notice", "vd"=>"root", "src"=>"109.171.83.127", "src_port"=>"45040", "src_int"=>"\"wan1\"", "dst"=>"153.16.xx.xx", "dst_port"=>"80", "dst_int"=>"\"VLAN-200\"", "SN"=>"3945", "status"=>"accept", "policyid"=>"16", "dst_country"=>"\"United States\"", "src_country"=>"\"Russian Federation\"", "dir_disp"=>"org", "tran_disp"=>"dnat", "tran_ip"=>"192.168.200.1", "tran_port"=>"80", "service"=>"HTTP", "proto"=>"6", "duration"=>"121", "sent"=>"60", "rcvd"=>"88", "sent_pkt"=>"1", "rcvd_pkt"=>"1"}

### kibana & elasticsearch

![](http://aimless.jp/images/demo.png)

## Requirement

If you want to input the syslog file, you must enable CSV FORMAT on fortigate.

    config log syslogd setting
        set csv enable
    end

## Installation

    git clone https://github.com/kongou-ae/fluent-plugin-fortigate-traffic-log.git
    ln -s  /path/to/current/dir/fluent-plugin-fortigate-traffic-log/in_fortigate_traffic_log.rb /path/to/fluent-plugin/dir/in_fortigate_traffic_log.rb

## Usage

add the configuration to your configuration file of fluent.

    <source>
      type fortigate-traffic-log
      path /path/to/your/log-file
      pos_file /path/to/your/posfile
      tag yourtag
      time_format %Y-%m-%d %H:%M:%S
    </source


## Licence

[MIT](https://github.com/tcnksm/tool/blob/master/LICENCE)

## Author

[kongou_ae](https://github.com/kongou-ae)