strongswan:
  pkg.installed:
    - name: strongswan
    - sources:
      - strongswan: salt://dn42/ipsec/strongswan-5.5.2-1-x86_64.pkg.tar.xz

  service.running:
    - name: strongswan
    - enable: True
    - require:
      - pkg: strongswan
    - watch:
      - file: /etc/ipsec.conf
      - file: /etc/ipsec.secrets


ipsec.conf:
  file.managed:
    - name: /etc/ipsec.conf
    - source: salt://dn42/ipsec/ipsec.conf.tpl
    - template: jinja
    - makedirs: True

ipsec.secrets:
  file.managed:
    - name: /etc/ipsec.secrets
    - source: salt://dn42/ipsec/ipsec.secrets.tpl
    - template: jinja
    - makedirs: True


{% for peer in pillar['dn42']['peers'].keys() -%}
peer.{{peer}}.pub:
  file.managed:
    - name: /etc/ipsec.d/public/{{ peer }}.pub
    - source: salt://dn42/ipsec/peer.pub.tpl
    - template: jinja
    - makedirs: True
    - context:
        peer: {{ peer }}
{% endfor -%}

ipsec.ferm:
  file.managed:
    - name: /etc/ferm/conf.d/30-dn42-ipsec.conf
    - source: salt://dn42/ipsec/ferm.conf.tpl
    - makedirs: True
    - template: jinja
    - require:
      - pkg: strongswan
#    - require_in:
#      - file: ferm
