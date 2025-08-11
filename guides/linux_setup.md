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
