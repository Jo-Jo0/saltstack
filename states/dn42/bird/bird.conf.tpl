# THIS FILE IS CONTROLLED BY SALTSTACK
#
# Bird IPv4 configuration


# Gateway-specific settings
#
# The unique ID of this router, its IPv4 address in the freifunk network
# and the AS number for freifunk fulda.
#
router id {{ pillar['dn42']['hosts'][grains['id']]['routerid'] }};
define ownas = {{ pillar['dn42']['as'] }};
define ownip = {{ pillar['dn42']['hosts'][grains['id']]['dn42']['ipv4'] }};



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
function is_default() { return net ~ [ 0.0.0.0/0]; }
function is_self_net() { return net ~ [ {{ pillar['dn42']['net']['ipv4'] }} ]; }
function is_freifunk() { return net ~ [ 10.0.0.0/8{15,24} ]; }
function is_dn42() { return net ~ [
        172.20.0.0/14{21,29},   # dn42 main net1
        172.22.0.0/23{23,32},   # dn42 Anycast
        172.23.0.0/24{24,32}    # dn42 Anycast
]; }


# Include all the other stuff
#
include "/etc/bird/bird.conf.d/*.conf";

