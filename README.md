# mkgs-nix

# bootstrap script

If you want to bootstrap an install, prepare /mnt and do

```
cd /mnt
DEVICE=device-name bash /etc/nixos/bootstrap.sh
```

This should take care of everything (will re-clone from master)

# conf

```
cd /mnt
mkdir etc
cd etc
git clone https://github.com/mkg20001/nix nixos
```

# hw conf

Link `devices/<name>` to `device`

```
ln -s devices/NAME device
```

# install

```
sudo chown -Rv root:root /mnt
sudo nixos-install --root /mnt
```
