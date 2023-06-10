package keeper

import (
	"github.com/merlin-network/fury/v6/x/govshuttle/types"
)

var _ types.QueryServer = Keeper{}
