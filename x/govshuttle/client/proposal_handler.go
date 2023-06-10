package client

import (
	govclient "github.com/cosmos/cosmos-sdk/x/gov/client"

	"github.com/merlin-network/fury/v6/x/erc20/client/rest"
	"github.com/merlin-network/fury/v6/x/govshuttle/client/cli"
)

var (
	LendingMarketProposalHandler = govclient.NewProposalHandler(cli.NewLendingMarketProposalCmd, rest.RegisterCoinProposalRESTHandler)
	TreasuryProposalHandler      = govclient.NewProposalHandler(cli.NewTreasuryProposalCmd, rest.RegisterCoinProposalRESTHandler)
)
