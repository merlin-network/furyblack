package keeper_test

import (
	_ "github.com/merlin-network/fury/v6/x/csr/keeper"
	sdk "github.com/cosmos/cosmos-sdk/types"
)

// params test suite
func (suite *KeeperTestSuite) TestParams() {
	params := suite.app.CSRKeeper.GetDefaultParams()
	// CSR is disabled by default
	suite.Require().False(params.EnableCsr)
	// Default CSRShares are 20%
	suite.Require().Equal(params.CsrShares, sdk.NewDecWithPrec(20, 2))
}
