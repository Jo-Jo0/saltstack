include:
  - tools

zsh:
    pkg.latest:
        - name:  zsh

zshrc:
    file.managed:
        - name: /root/.zshrc
        - source: salt://zsh/files/zshrc.tmpl
        - makedirs: true
        - template: jinja

oh_my_zsh:
  git.latest:
    - name: git://github.com/robbyrussell/oh-my-zsh.git
    - target: /opt/oh-my-zsh

{% if salt.cmd.run('echo $SHELL') != '/usr/bin/zsh' %}
default_shell:
  cmd:
    - run
    - name: "chsh -s /usr/bin/zsh root"
    - requires: zsh
{% endif -%}
