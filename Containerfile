FROM ghcr.io/cgwalters/fedora-silverblue:37
# See https://pagure.io/releng/issue/11047 for final location

# Remove gnome-terminal and add gnome-console, gnome-tweaks, and distrobox
# RUN rpm-ostree override remove gnome-terminal gnome-terminal-nautilus && \ 
#     rpm-ostree install --assumeyes gnome-tweaks distrobox zsh
RUN rpm-ostree install --assumeyes --apply-live gnome-console

# Remove gnome-terminal and add a wrapper for gnome-terminal
COPY ./scripts/kgx-gnome-terminal-wrapper /usr/local/bin/gnome-terminal
RUN chmod +x /usr/local/bin/gnome-terminal
RUN rpm-ostree override remove gnome-terminal gnome-terminal-nautilus

# RUN rpm-ostree override remove gnome-terminal gnome-terminal-nautilus && \
#     rpm-ostree install gnome-tweaks distrobox zsh

# COPY scripts/purple-tree-pre-boot /usr/local/bin/purple-tree-pre-boot
# COPY scripts/purple-tree-first-boot /usr/local/bin/purple-tree-first-boot

# If you want to use a nvidia gpu, you need to install the nvidia-drivers
# https://docs.fedoraproject.org/en-US/fedora-silverblue/troubleshooting/#_using_nvidia_drivers
# https://blogs.gnome.org/alexl/2019/03/06/nvidia-drivers-in-fedora-silverblue/

# IF you want to use RPM Fusion, you need to do the following
# https://docs.fedoraproject.org/en-US/quick-docs/setup_rpmfusion/#proc_enabling-the-rpmfusion-repositories-for-ostree-based-systems_enabling-the-rpmfusion-repositories
# https://docs.fedoraproject.org/en-US/fedora-silverblue/tips-and-tricks/#_enabling_rpm_fusion_repos
# RUN rpm-ostree install --assumeyes \
#     https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
#     https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

# Between major releases, we need to do a cleanup
# RUN rpm-ostree update --assumeyes \
#     --uninstall rpmfusion-free-release \
#     --uninstall rpmfusion-nonfree-release \
#     --install rpmfusion-free-release \
#     --install rpmfusion-nonfree-release


RUN rpm-ostree cleanup -m && \
    ostree container commit

