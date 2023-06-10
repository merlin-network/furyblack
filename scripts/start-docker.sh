#!/bin/bash

KEY="mykey"
CHAINID="highbury_9000-1"
MONIKER="mymoniker"
DATA_DIR=$(mktemp -d -t fury-datadir.XXXXX)

echo "create and add new keys"
./fury keys add $KEY --home $DATA_DIR --no-backup --chain-id $CHAINID --algo "eth_secp256k1" --keyring-backend test
echo "init fury with moniker=$MONIKER and chain-id=$CHAINID"
./fury init $MONIKER --chain-id $CHAINID --home $DATA_DIR
echo "prepare genesis: Allocate genesis accounts"
./fury add-genesis-account \
"$(./fury keys show $KEY -a --home $DATA_DIR --keyring-backend test)" 1000000000000000000afury,1000000000000000000stake \
--home $DATA_DIR --keyring-backend test
echo "prepare genesis: Sign genesis transaction"
./fury gentx $KEY 1000000000000000000stake --keyring-backend test --home $DATA_DIR --keyring-backend test --chain-id $CHAINID
echo "prepare genesis: Collect genesis tx"
./fury collect-gentxs --home $DATA_DIR
echo "prepare genesis: Run validate-genesis to ensure everything worked and that the genesis file is setup correctly"
./fury validate-genesis --home $DATA_DIR

echo "starting fury node $i in background ..."
./fury start --pruning=nothing --rpc.unsafe \
--keyring-backend test --home $DATA_DIR \
>$DATA_DIR/node.log 2>&1 & disown

echo "started fury node"
tail -f /dev/null