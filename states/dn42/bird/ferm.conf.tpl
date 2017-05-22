# THIS FILE IS CONTROLLED BY SALTSTACK!
#
# IPv4 / IPv6 firewall - bird rules for dn42

domain (ip ip6)
table filter {
  chain INPUT {
    {% for peer in pillar['dn42']['peers'].keys() -%}
    interface tun-{{ peer }} proto tcp dport 179 ACCEPT;
    {% endfor %}
  }
}

