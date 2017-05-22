#### This File is managed by Saltstack, any changes will be overwritten! ####

#strongswan IPsec secrets file

: RSA {{salt['grains.get']('host')}}.pem
