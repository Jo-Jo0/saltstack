screenrc:
  file.managed:
    - name: /root/.screenrc
    - source: salt://common/files/screenrc.tmpl
    - makedirs: True
    - template: jinja
