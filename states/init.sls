#!jinja|yaml

{% set datamap = salt['formhelper.defaults']('squid', saltenv) %}

# SLS includes/ excludes
include: {{ datamap.sls_include|default([]) }}
extend: {{ datamap.sls_extend|default({}) }}

squid:
  pkg:
    - installed
    - pkgs: {{ datamap.pkgs }}
  service:
    - {{ datamap.ensure|default('running') }}
    - name: {{ datamap.service.name|default('squid3') }}
    - enable: {{ datamap.service.enable|default(True) }}
  file:
    - managed
    - name: {{ datamap.config.main.path|default('/etc/squid3/squid.conf') }}
    - mode: 644
    - user: root
    - group: root
    - contents_pillar: squid:lookup:config:main:content
    - watch_in:
      - service: squid
