include:
  - tools

weechat:
  pkg.latest:
    - name: weechat
#  file.managed:
#    - name: /root/.weechat/weechat.conf
#    - source: salt://weechat/files/weechat.conf.tmpl
#    - makedirs: True

weechat.user:
  user.present:
    - name: weechat
    - home: /opt/weechat
    - createhome: True
    - empty_password: True
  ssh_auth.present:
    - name: {{ pillar['ssh']['authorized_keys']['jo-jo'] }}
    - user: weechat
    - comment: jo-jo
    - options: 
       - no-port-forwarding
       - no-X11-forwarding

weechat.service:
  file.managed:
    - name: /etc/systemd/system/weechat.service
    - source: salt://weechat/files/service.tmpl
    - makedirs: True
  service.running:
    - name: weechat
    - enable: True
    - require:
       - pkg: weechat
       - pkg: screen 
       - file: /etc/systemd/system/weechat.service
