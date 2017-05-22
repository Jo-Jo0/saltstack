# Load gre kernel module
#
dn42.gre.kmod:
  kmod.present:
    - name: ip6_gre
    - persist: True


# Add tunnel interface
#
{% for peer in pillar['dn42']['peers'].keys() -%}
## systemd-networkd Files:
{{ peer }}.netdev:
  file.managed:
    - name: /etc/systemd/network/gre.{{ peer }}.netdev
    - source: salt://dn42/gre/files/networkd.netdev.tmpl
    - makedirs: True
    - template: jinja
    - context:
         remote: {{ peer }}
###
{{ peer }}.network:
  file.managed:
    - name: /etc/systemd/network/gre.{{ peer }}.network
    - source: salt://dn42/gre/files/networkd.network.tmpl
    - makedirs: True
    - template: jinja
    - context:
         remote: {{ peer }}
###
## Add entrys in main ethernet Interface

{{ peer }}.tunnelEntry:
  file.append:
    - name: /etc/systemd/network/wired.network
    - text: 
       - 'Tunnel = {{ peer }}.gre'
{%- endfor %}

# Install firewall rules to allow gre traffic from and to peers
#
dn42.gre.ferm:
  file.managed:
    - name: /etc/ferm/conf.d/30-dn42-gre.conf
    - source: salt://dn42/gre/files/ferm.conf.jinja
    - template: jinja
    - makedirs: True
#    - require_in:
#      - file: ferm
