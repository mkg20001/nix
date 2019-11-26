# mkgs-nix

# conf

```
cd /mnt
mkdir etc
cd etc
git clone https://github.com/mkg20001/nix nixos
```

# hw conf

Link `hardware/<name>.nix` to `hardware-configuration.nix`

```
ln -s hardware/NAME.nix hardware-configuration.nix
ln -s device/NAME/index.nix device.nix
```

# install

```
sudo chown -Rv root:root /mnt
sudo nixos-install --root /mnt
```
