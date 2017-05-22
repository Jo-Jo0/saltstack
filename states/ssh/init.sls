{% if grains.os == 'Arch' %}
{% set sshpkg = 'openssh' %}
{% endif %}
{% if grains.os == 'Debian' %}
{% set sshpkg = 'openssh-server' %}
{% endif %} 


sshd:
    pkg.latest:
        - name: {{ sshpkg }}
    service.running:
        - enable: True
        - name: sshd
        - require:
            - pkg: {{ sshpkg }}
        - watch:
            - file: /etc/ssh/sshd_config

sshd.conf:
    file.managed:
        - name: /etc/ssh/sshd_config
        - source: salt://ssh/files/sshd.conf.tmpl
        - makedirs: True
        - template: jinja

{% for owner, key in pillar['ssh']['authorized_keys'].items() %}
sshd.root.authorized_keys.{{ owner }}:
  ssh_auth.present:
    - user: root
    - name: {{ key }}
    - comment: {{ owner }}
{% endfor %}
