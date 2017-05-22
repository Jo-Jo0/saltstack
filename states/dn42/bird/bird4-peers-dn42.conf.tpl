{% for peer, values in pillar['dn42']['peers'].iteritems() if 'tun4' in values %}
protocol bgp dn42_{{ peer }} from bgp_dn42 {
          neighbor {{ values['tun4']['right'] }} as {{ values['as'] }};
};
{% endfor %}
