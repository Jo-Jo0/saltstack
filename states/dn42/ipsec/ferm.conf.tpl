# THIS FILE IS CONTROLLED BY SALTSTACK!
#
# IPv4 firewall - ipsec rules

domain (ip ip6)
table filter {
  chain INPUT {
    # ESP encrypton and authentication
    #
    proto 50 ACCEPT;

    # AH (authentication header)
    #
    proto 51 ACCEPT;

    # IKE
    #
    proto udp dport 500 {
      {% for peer, values in pillar['dn42']['peers'].iteritems() -%}
      saddr {{ values['remote'] }} ACCEPT;
      {% endfor %}
    }

    # NAT traversal
    #
    proto udp dport 4500 {
      {% for peer, values in pillar['dn42']['peers'].iteritems() -%}
      saddr {{ values['remote'] }} ACCEPT;
      {% endfor %}
    }
  }
}

