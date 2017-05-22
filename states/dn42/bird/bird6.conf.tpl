# THIS FILE IS CONTROLLED BY SALTSTACK
#
# Gateway-specific Bird IPv6 configuration
#



# Gateway-specific settings
#
# The unique ID of this router, its IPv6 address in the freifunk network
# and the AS number for freifunk fulda.
#
router id {{ pillar['dn42']['hosts'][grains['id']]['routerid'] }};
define ownas = {{ pillar['dn42']['as'] }};
define ownip = {{ pillar['dn42']['hosts'][grains['id']]['dn42']['ipv6'] }};



# Routing tables
#
# This will create the routing tables bird will use.
#
table private;             # icvpn, dn42, ...
table sink;                # sink for any source except local



# Match specific networks
#
# These functions are used to match specific networks, like freifunk or
# our own network prefix. It gets used by the protocols to filter routeing
# advertisements from and to our peers.
#
function is_default() { return net ~ [ ::/0 ]; }
function is_self_net() { return net ~ [ fd42:d42:2706::/48+ ]; }
function is_freifunk() { return net ~ [
	2001:0bf7::/32+,	# Foerderverein freie Netzwerke e.V.
	2001:67c:2d50::/48+,	# Freifunk Luebeck (via FF Rheinland)
	2a03:2260::/29+ 	# Freifunk Rheinland e.V.
]; }
function is_ula() { return (net ~ [ fc00::/7{44,64} ]); };



# Include all the other stuff
#
include "/etc/bird/bird6.conf.d/*.conf";

