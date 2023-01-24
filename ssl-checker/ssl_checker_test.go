package ssl_checker

import (
	"github.com/stretchr/testify/require"
	"testing"
)

func TestSSLChecker(t *testing.T) {
	goodHost := "fearless.tech"
	badHost := "badssl.com"

	goodResp, err := SSLChecker(goodHost)
	require.NoError(t, err)
	require.Equal(t, goodResp.DomainName, []string{"fearless.tech", "*.fearless.tech"})
	require.Equal(t, goodResp.IsValid, true)
	require.Greater(t, goodResp.DaysUntilExpiration, 0)

	badResp, err := SSLChecker(badHost)
	require.NoError(t, err)
	require.Equal(t, badResp.IsValid, true)
	require.Equal(t, badResp.DomainName, []string{"*.badssl.com", "badssl.com"})
}
