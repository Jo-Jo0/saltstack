vimrc:
    file.managed:
        - name: /root/.vimrc
        - source: salt://common/files/vimrc.tmpl
        - makedirs : True
        - template: jinja
