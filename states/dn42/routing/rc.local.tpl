#!/bin/sh


# all traffic will lookup table private, where routes for IC-VPN, dn42
# and our own network are located.
#
/sbin/ip -4 rule add prio 100 table private
/sbin/ip -6 rule add prio 100 table private

# everything except local traffic will hit the sink table with
# an unreachable default route, instead of looking up main table
#
{% for peer, values in pillar['dn42']['peers'].iteritems() %}
/sbin/ip -4 rule add prio 190 iif {{peer}}.dn42.gre table sink
/sbin/ip -6 rule add prio 190 iif {{peer}}.dn42.gre table sink
{% endfor %}
