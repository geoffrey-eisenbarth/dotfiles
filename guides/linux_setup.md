# Common commands after a fresh Debian install


## Remove root access

Log in as root.

```
> apt-get update
> apt-get upgrade
```

```
> adduser --gecos '' <username>
> usermod -G sudo,www-data <username>
```

Make sure that `/etc/ssh/sshd_config` has `PermitRootLogin` set to `no` or `prohibit-password`.
Run `service ssh restart` if necessary.


## Set up SSH keys

On local machine, run `ssh-copy-id -p 2222 <username>@<remote_host>` 

To enable SSH agent forwarding, make sure that `ForwardAgent yes` is added in `~/.ssh/config`


## Clone dotfiles repo

```
> su -
> apt install sudo
> exit
> sudo apt install git
> mkdir ~/.dotfiles/ 
> cd ~/.dotfiles
> git clone git@github.com:geoffrey-eisenbarth/dotfiles.git .
> ./setup.sh 
```

## Install webserver and database

```
> sudo apt install nginx

```

Install [certbot](https://certbot.eff.org/instructions?ws=nginx&os=pip)

```
> sudo apt install python3 python3-dev python3-venv libaugeas-dev gcc
> sudo apt-get remove certbot
> sudo python3 -m venv /opt/certbot/
> sudo /opt/certbot/bin/pip install --upgrade pip
> sudo /opt/certbot/bin/pip install certbot certbot-nginx
> sudo ln -s /opt/certbot/bin/certbot /usr/bin/certbot


# When ready to install certs:
> sudo certbot --nginx
```

Install and initialize PostgreSQL:

```
> sudo apt install postgresql libpq-dev
> sudo -u postgres -i
> psql
 $ CREATE USER <username> WITH ENCRYPTED PASSWORD '<password>';
 $ CREATE DATABASE <website> WITH OWNER <username> ENCODING 'UTF8';
 $ GRANT ALL PRIVILEGES ON DATABASE perryman TO server;
 $ exit
 $ exit
```

## Install Python Poetry

```
> sudo apt update
> sudo apt install pipx
> pipx install poetry
> pipx upgrade poetry
> pipx ensurepath
```

## Create necessary folders and set permissions

```
> sudo mkdir /srv/tpg
> sudo mkdir /srv/tpg/.well-known
> sudo mkdir /srv/tpg/static
> sudo mkdir /srv/tpg/media
> sudo chmod -R g+rwx /srv/tpg
> sudo chgrp -R www-data /srv/tpg


> sudo vim /etc/tmpfiles.d/gunicorn.conf

  # Type Path Mode UID GID Age Argument
  d /run/gunicorn 0775 server www-data - -

> sudo systemd-tmpfiles --create /etc/tmpfiles.d/gunicorn.conf

```

## Creating new process manager

```
# /etc/systemd/system/gunicorn.service

[Unit]
Description=gunicorn daemon
After=network.target

[Service]
User=your_username
Group=www-data
WorkingDirectory=/home/server/tpg/
ExecStart=/home/server/tpg/.venv/bin/gunicorn --access-logfile - --workers 3 --bind unix:/run/gunicorn/tpg.sock perryman.wsgi:application

[Install]
WantedBy=multi-user.target

```

```
> sudo systemctl daemon-reload
> sudo systemctl start gunicorn
> sudo systemctl enable gunicorn
> sudo systemctl status gunicorn
```

## Deploy project

```
> mkdir /home/server/tpg
> cd /home/server/tpg
> git clone git@gitlab.com:geoffrey.eisenbarth/perryman.git .

> mkdir /home/server/.venv/
> cd /home/server/tpg && poetry config virtualenvs.in-project true --local
> poetry install

> export TPG_DJANGO_ENV="stage"

> poetry run ./manage.py migrate --no-input --database=default
> poetry run ./manage.py collectstatic -v 0 --noinput
> poetry run ./manage.py compress
```
