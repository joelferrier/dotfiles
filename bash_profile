# .bash_profile

# User specific environment and startup programs

PATH=$PATH:$HOME/.local/bin:$HOME/bin:/usr/local/lib
export PATH


export CLICOLOR=1
export EDITOR="vim"

#aliases
alias ..='cd ..'
alias ll='ls -l'
alias la='ls -a'
alias excuse='telnet towel.blinkenlights.nl 666 2>/dev/null |tail -2'
alias c='clear'

alias vpn='sudo openvpn /home/user/.keys/client.ovpn'
alias subl='sublime'
alias mv='timeout 10 mv -iv'
alias bright='xbacklight -set '

function dnsvpn()
{
    if [ -f /etc/resolv.conf.vpn ]; then
        sudo mv /etc/resolv.conf /etc/resolv.conf.novpn;
        sudo mv /etc/resolv.conf.vpn /etc/resolv.conf;
        echo 'switching to vpn dns server';
    elif [ -f /etc/resolv.conf.novpn ]; then
        sudo mv /etc/resolv.conf /etc/resolv.conf.vpn;
        sudo mv /etc/resolv.conf.novpn /etc/resolv.conf;
        echo 'switching off vpn dns server';
    else
        echo 'error switching primary dns'
    fi
}

function statdnsvpn()
{
    if [ -f /etc/resolv.conf.vpn ]; then
        echo 'dns off vpn';
    elif [ -f /etc/resolv.conf.novpn ]; then
        echo 'dns on vpn';
    else
        echo 'no alternate resolv.conf found';
    fi
}

function torstat()
{
    if [ -f /var/tmp/tor.lock ]; then
        echo 'tor firewall on';
    else
        echo 'tor firewall off';
    fi
}

function tortoggle()
{
    if [ -f /var/tmp/tor.lock ];then
        sudo rm /var/tmp/tor.lock;
        sudo iptables-restore < /home/user/.restore/iptables-02-16-15;
        sudo systemctl stop tor;
    else
        sudo systemctl start tor;
        . /home/user/.restore/tor.sh;
    fi
}

function bcc()
{
    echo "$@" | bc;
}

#TODO: rename
function pyenv()
{
    USAGE="usage: pyenv [new|use|deactivate] <environment>
    use:        uses a virtualenv with the name <environment>
    deactivate: deactivates the current virtualenv
    list:       lists availible virtualenvs
    new:        creates a new virtualenv with the name <environment>"

    # check to see if we are in a virtual environment
    [[ "${VIRTUAL_ENV}" == "" ]]; INVENV=$?

    if [ -z "${1}" ] || [ $# -gt 2 ] ;then
        echo "${USAGE}";
    elif [ -z "${2}" ];then
        if [ "${1}" == "deactivate" ]; then
            if [ ${INVENV} == "1" ]; then
                deactivate;
            else
                echo "no active virtualenv found";
            fi
        elif [ "${1}" == "list" ]; then
            if [ -d ~/pyenv/ ]; then
                ls ~/pyenv/;
            else
                echo "pyenv directory missing:";
                echo "    ~/pyenv";
            fi
        else
            echo "${USAGE}";
        fi
    else
        if [ "${1}" == "use" ]; then
            if [ -d ~/pyenv/${2} ]; then
                if [ "${INVENV}" == "1" ]; then
                    deactivate;
                fi
                source ~/pyenv/${2}/bin/activate;
                echo "activating ~/pyenv/${2}/";
            else
                echo "specified env directory does not exist:";
                echo " ~/pyenv/${2}/";
            fi
        elif [ "${1}" == "new" ]; then
            if [[ -d "~/pyenv/${2}" ]]; then
                echo "cannot create env, directory already exists:";
                echo "  ~/pyenv/${2}/";
            else
                mkdir -p ~/pyenv/${2}/;
                virtualenv ~/pyenv/${2};
                echo "new virtualenv created:";
                echo "  ~/pyenv/${2}";
            fi
        else
            echo "${USAGE}";
        fi
    fi

}

alias lock="xscreensaver-command -lock"
alias mute="amixer set Master toggle > /dev/null"

. ~/.private_bash
. ~/.bash_prompt

