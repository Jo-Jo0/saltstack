# THIS FILE IS CONTROLLED BY SALTSTACK!
#
# IPv4 firewall - forwarding rules


# TABLE: FORWARD (POLICY DROP)
#
domain ip
table filter {
    chain FORWARD {
        policy DROP;

        # Allow established connections
        #
        mod conntrack ctstate (ESTABLISHED RELATED) ACCEPT;

{%- for peer1, values1 in pillar['dn42']['peers'].iteritems() %}
        # dn42 <-> tun-{{ peer1 }}
        #
        interface dn42 outerface tun-{{peer1}} ACCEPT;
        interface tun-{{peer1}} outerface dn42 ACCEPT;

  {%- for peer2, values2 in pillar['dn42']['peers'].iteritems() if peer2 != peer1 %}
        # tun-{{ peer1 }} <-> tun-{{ peer2 }}
        #
        interface tun-{{peer1}} outerface tun-{{peer2}} ACCEPT;
  {% endfor %}
{% endfor -%}

        # LOG all DROPed traffic
        #
        LOG log-prefix "FORWARD[drop]: ";                            # LOG dropped traffic for debugging
    }
}

