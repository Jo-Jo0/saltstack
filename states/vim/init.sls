vim:
    pkg.latest:
        - name: vim

vimrc:
    file.managed:
        - name: /root/.vimrc
        - source: salt://vim/files/vimrc.tmpl
        - makedirs : True
        - template: jinja
