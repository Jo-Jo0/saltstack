# THIS FILE IS CONTROLLED BY SALTSTACK!
#
# ipsec.conf - strongSwan IPsec configuration file


config setup
	# strictcrlpolicy=yes
	# uniqueids = no


# Defaults
#
conn %default
	keyexchange=ikev2
	ikelifetime=28800s
	type=transport
	leftprotoport=gre
	rightprotoport=gre
	ike=aes256-sha256-modp4096!
	esp=aes256-sha256-modp4096!
	dpdaction=restart
	leftsubnet=%dynamic[gre]
	rightsubnet=%dynamic[gre]
	auto=route
	dpddelay=30s
	dpdtimeout=120s
	dpdaction=restart
	lifetime=3600s


# Peers
#
{% for peer, values in pillar['dn42']['peers'].iteritems() %}
conn tun-{{ peer }}
	authby=pubkey
	{% if pillar.dn42.peers[peer].proto == "ip6gre" -%}
	left={{ pillar.dn42.hosts[grains['id']].public.ipv6 }}
	{% elif  pillar.dn42.peers[peer].proto == "gre" -%}
	left={{ pillar.dn42.hosts[grains['id']].public.ipv4 }}
	{% endif -%}
	right={{ values['remote'] }}
	leftrsasigkey=/etc/ipsec.d/public/{{ salt['grains.get']('host')}}.pem
	rightrsasigkey=/etc/ipsec.d/public/{{ peer }}.pub
	keyexchange={{ values['keyexchange']}}
	ike={{ values['ike'] }}
	esp={{ values['esp'] }}

{% endfor %}



include /var/lib/strongswan/ipsec.conf.inc
