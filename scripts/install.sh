#!/usr/bin/env bash
set -e

release="$(lsb_release -s -c)"


add_deb_multimedia_repo() {
    deb_multimedia_file="/etc/apt/sources.list.d/dmo.sources"
    #deb_multimedia_repo="https://www.deb-multimedia.org"
    deb_multidemia_repo="https://mirror.yandex.ru/debian-multimedia/"

    if [[ ! -f "$deb_multimedia_file" ]]
    then
        printf '%s\n' \
        'Types: deb' \
        "URIs: ${deb_multidemia_repo}" \
        "Suites: ${release}" \
        'Components: main non-free' \
        'Signed-By: /usr/share/keyrings/deb-multimedia-keyring.pgp' \
        'Enabled: yes' \
        '' \
        'Types: deb' \
        "URIs: ${deb_multidemia_repo}" \
        "Suites: ${release}-backports" \
        'Components: main' \
        'Signed-By: /usr/share/keyrings/deb-multimedia-keyring.pgp' \
        'Enabled: yes' \
        | tee "$deb_multimedia_file" > /dev/null

        wget -O /tmp/deb-multimedia-keyring_all.deb \
                https://www.deb-multimedia.org/pool/main/d/deb-multimedia-keyring/deb-multimedia-keyring_2024.9.1_all.deb
        apt install -y /tmp/deb-multimedia-keyring_all.deb
        rm /tmp/deb-multimedia-keyring_all.deb

        apt update
    fi
}


apt update && apt install -y --no-install-recommends \
    git \
    stow \
    tmux \
    zsh

if [ ! -d "$HOME/.oh-my-zsh" ]
then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
else
    echo "Oh My Zsh already installed."
fi

add_deb_multimedia_repo

exit 0
