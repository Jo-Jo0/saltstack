bird:
  pkg.latest:
    - name: bird
  service.running:
    - name: bird
    - enable: True
    - reload: True
    - require:
      - pkg: bird
    - watch:
      - file: /etc/bird/*

bird6:
  pkg.latest:
    - name: bird6
  service.running:
    - name: bird6
    - enable: True
    - reload: True
    - require:
      - pkg: bird6
    - watch:
      - file: /etc/bird/*


# bird ipv4 configuration
#
/etc/bird/bird.conf:
  file.managed:
    - name: /etc/bird.conf
    - user: root
    - group: root
    - mode: 644
    - source: salt://dn42/bird/bird.conf.tpl
    - template: jinja
    - require:
      - pkg: bird

/etc/bird/bird.conf.d:
  file.recurse:
    - user: root
    - group: root
    - dir_mode: 755
    - file_mode: 644
    - source: salt://dn42/bird/bird.conf.d
    - include_empty: True
    - makedirs: True
    - template: jinja
    - require:
      - pkg: bird

/etc/bird/dn42/bird4-peers-dn42.conf:
  file.managed:
    - name: /etc/bird/dn42/bird4-peers-dn42.conf
    - user: root
    - group: root
    - mode: 644
    - source: salt://dn42/bird/bird4-peers-dn42.conf.tpl
    - template: jinja
    - makedirs: True


# bird ipv6 configuration
#
/etc/bird/bird6.conf:
  file.managed:
    - name: /etc/bird6.conf
    - user: root
    - group: root
    - mode: 644
    - source: salt://dn42/bird/bird6.conf.tpl
    - template: jinja
    - require:
      - pkg: bird6

/etc/bird/bird6.conf.d:
  file.recurse:
    - user: root
    - group: root
    - dir_mode: 755
    - file_mode: 644
    - source: salt://dn42/bird/bird6.conf.d
    - include_empty: True
    - makedirs: True
    - template: jinja
    - require:
      - pkg: bird6

/etc/bird/dn42/bird6-peers-dn42.conf:
  file.managed:
    - name: /etc/bird/dn42/bird6-peers-dn42.conf
    - user: root
    - group: root
    - mode: 644
    - source: salt://dn42/bird/bird6-peers-dn42.conf.tpl
    - template: jinja
    - makedirs: True



bird.ferm:
  file.managed:
    - name: /etc/ferm/conf.d/31-dn42-bird.conf
    - source: salt://dn42/bird/ferm.conf.tpl
    - makedirs: True
    - template: jinja
#    - require_in:
#      - file: ferm


# monitoring (snmp)
bird.bgp_status:
  file.managed:
    - name: /etc/snmp/bgp_session.sh
    - source: salt://dn42/bird/snmp_bgp_session.sh
    - makedirs: True
    - require:
      - pkg: bird
