{% for peer, values in pillar['dn42']['peers'].iteritems() if 'tun6' in values %}
protocol bgp dn42_{{ peer }} from bgp_dn42 {
          neighbor {{ values['tun6']['right'] }} % '{{ peer }}.gre' as {{ values['as'] }};
};
{% endfor %}
