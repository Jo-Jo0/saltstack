dn42.forward.ipv4.conf:
  file.managed:
    - name: /etc/ferm/conf.d/85-forward.ipv4.conf
    - source: salt://dn42/routing/85-forward.ipv4.conf.tpl
    - user: root
    - group: root
    - mode: 644
    - makedirs: True
    - template: jinja
#    - require_in:
#      - file: ferm


dn42.forward.ipv6.conf:
  file.managed:
    - name: /etc/ferm/conf.d/85-forward.ipv6.conf
    - source: salt://dn42/routing/85-forward.ipv6.conf.tpl
    - user: root
    - group: root
    - mode: 644
    - makedirs: True
    - template: jinja
#    - require_in:
#      - file: ferm


# routing tables
#
/etc/iproute2/rt_tables:
  file.managed:
    - name: /etc/iproute2/rt_tables
    - user: root
    - group: root
    - mode: 644
    - source: salt://dn42/routing/rt_tables


# routing rules
#
/etc/rc.local:
  file.managed:
    - name: /etc/rc.local
    - user: root
    - group: root
    - mode: 755
    - source: salt://dn42/routing/rc.local.tpl
    - template: jinja
