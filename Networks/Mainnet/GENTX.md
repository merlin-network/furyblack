# GENTX & HARDFORK INSTRUCTIONS

### Install & Initialize

-   Install fury binary

-   Initialize fury node directory

```bash
fury init <node_name> --chain-id highbury_710-1
```

-   Download the [genesis file](https://github.com/merlin-network/fury/raw/genesis/Networks/Mainnet/genesis.json)

```bash
wget https://github.com/merlin-network/fury/raw/genesis/Networks/Mainnet/genesis.json -b $HOME/.fury/config
```

### Create & Submit a GENTX file + genesis.json

A GENTX is a genesis transaction that adds a validator node to the genesis file.

```bash
fury gentx <key_name> <token-amount>afury --chain-id=highbury_710-1 --moniker=<your_moniker> --commission-max-change-rate=0.01 --commission-max-rate=0.10 --commission-rate=0.05 --details="<details here>" --security-contact="<email>" --website="<website>"
```

-   Fork [Fury](https://github.com/merlin-network/fury)

-   Copy the contents of `${HOME}/.fury/config/gentx/gentx-XXXXXXXX.json` to `$HOME/Fury/Mainnet/Gentx/<yourvalidatorname>.json`

-   Create a pull request to the genesis branch of the [repository](https://github.com/merlin-network/fury/Mainnet/gentx)

### Restarting Your Node

You do not need to reinitialize your Fury Node. Basically a hard fork on Cosmos is starting from block 1 with a new genesis file. All your configuration files can stay the same. Steps to ensure a safe restart

1. Backup your data directory.

-   `mkdir $HOME/fury-backup`

-   `cp $HOME/.fury/data $HOME/fury-backup/`

2. Remove old genesis

-   `rm $HOME/.fury/genesis.json`

3. Download new genesis

-   `wget`

4. Remove old data

-   `rm -rf $HOME/.fury/data`

6. Create a new data directory

-   `mkdir $HOME/.fury/data`

7. copy the contents of the `priv_validator_state.json` file 

-   `nano $HOME/.fury/data/priv_validator_state.json`

-   Copy the json string and paste into the file
 {
"height": "0",
 "round": 0,
 "step": 0
 }

If you do not reinitialize then your peer id and ip address will remain the same which will prevent you from needing to update your peers list.

8. Download the new binary

```
cd $HOME/Fury
git checkout <branch>
make install
mv $HOME/go/bin/fury /usr/bin/
```

9. Restart your node

-   `systemctl restart fury`

## Emergency Reversion

1. Move your backup data directory into your .fury directory

-   `mv HOME/fury-backup/data $HOME/.fury/`

2. Download the old genesis file

-   `wget https://github.com/merlin-network/fury/raw/main/Mainnet/genesis.json -b $HOME/.fury/config/`

3. Restart your node

-   `systemctl restart fury`
