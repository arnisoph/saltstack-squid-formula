squid:
  lookup:
    config:
      main:
        content: |
          acl manager proto cache_object
          acl localhost src 127.0.0.1/32 ::1
          acl to_localhost dst 127.0.0.0/8 0.0.0.0/32 ::1
          acl moa src 127.0.0.1
          acl SSL_ports port 443
          acl Safe_ports port 80    # http
          acl Safe_ports port 21    # ftp
          acl Safe_ports port 443   # https
          acl Safe_ports port 70    # gopher
          acl Safe_ports port 210   # wais
          acl Safe_ports port 1025-65535  # unregistered ports
          acl Safe_ports port 280   # http-mgmt
          acl Safe_ports port 488   # gss-http
          acl Safe_ports port 591   # filemaker
          acl Safe_ports port 777   # multiling http
          acl CONNECT method CONNECT
          http_access allow manager localhost
          http_access deny manager
          http_access allow moa
          http_access deny !Safe_ports
          http_access deny CONNECT !SSL_ports
          http_access allow localhost
          http_access allow all
          http_port 0.0.0.0:3128
          coredump_dir /var/spool/squid3
          cache_dir ufs /var/spool/squid3 4096 16 256
          refresh_pattern ^ftp:   1440  20% 10080
          refresh_pattern ^gopher:  1440  0%  1440
          refresh_pattern -i (/cgi-bin/|\?) 0 0%  0
          refresh_pattern .   0 20% 4320
