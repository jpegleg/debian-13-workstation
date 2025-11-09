#!/usr/bin/env sh

set -e
apt-get install apt-transport-https -y
apt-get install aptitude -y
aptitude update && aptitude upgrade -y
aptitude install curl git vim -y
aptitude install pipewire pipewire-alsa pipewire-audio pipewire-audio-client-libraries pipewire-jack pipewire-pulse libspa-0.2-jack wireplumber -y
cp /usr/share/doc/pipewire/examples/ld.so.conf.d/pipewire-jack-*.conf /etc/ld.so.conf.d/
ldconfig
sed -i 's/GRUB_CMDLINE_LINUX_DEFAULT="quiet"/GRUB_CMDLINE_LINUX_DEFAULT="quiet threadirqs cpufreq.default_governor=performance mds=full,nosmt"/g' /etc/default/grub
update-grub
echo '@audio - rtprio 90
@audio - memlock unlimited' | tee -a /etc/security/limits.d/audio.conf
echo 'vm.swapiness=10
fs.inotify.max_user_watches=6000000' | tee -a /etc/sysctl.conf
mkdir -pm755 /etc/apt/keyrings
aptitude update
aptitude install libnotify-bin -y
aptitude install inkscape gimp gcc tmux clang ufw python3-venv -y
