#!/usr/bin/env bash
set -e
useradd -m ansible
echo "ansible ALL=(ALL) NOPASSWD: ALL" >/etc/sudoers.d/ansible
mkdir -p /home/ansible/.ssh
echo 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCqcVM2rBWxhd3Jhd4vGFots9dZywSzbfBJQ8awnZgMJQS1tIVawe1EmJ2dRrfueQvM3kKvzGPznuZi71XsZ/d3eihhMSeS0TYz5GR0Cpqv2sMKL4XfZ2T/oD8zJ7DMX2WOkKoMHjhW44hlindOJS0ZxsJapCGPFeHa+ZgTSy/jG4+s2/OPbhXDpghhjlc29PKgC8+9BgrF3mPw/I+RcitV7+RAoQjTiV+CsSypYTLoW8DAuF4gisZOTi1hMAadT7l4hKo1K3p7eQjnY0j//vWzHKFmZbgWWrluuMpWaU159vH6J3toZpwMYKz/gtOOc37WZMAYrPUAMlX+XauSNxoRAJW2z0jXntg9WlcX046tdj97a0+wGujeeYuDNeA8SUtQOGGaUoZhitJiT1HqWIVI/JB/V2f401Owj6P2hn2Gg2SUr9SD2D2GghflWzIBiWlQDNFFS5DcTuERmr9ElGGmvXyIyO0/Im2/OrcdNMeuQ/kP/TrGJm/6UybTQou36mM= nico@T440p-void' >/home/ansible/.ssh/authorized_keys
pacman -Syu python
