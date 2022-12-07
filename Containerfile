FROM ghcr.io/cgwalters/fedora-silverblue:37
# See https://pagure.io/releng/issue/11047 for final location

# Remove gnome-terminal and add gnome-console, gnome-tweaks, and distrobox
RUN rpm-ostree override remove gnome-terminal gnome-terminal-nautilus && \
    rpm-ostree install gnome-console gnome-tweaks distrobox zsh

RUN ln -s /usr/bin/kgx /usr/local/bin/gnome-terminal

RUN rpm-ostree cleanup -m && \
    ostree container commit

