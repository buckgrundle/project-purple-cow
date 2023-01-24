package ssl_checker

import (
	"crypto/tls"
	"net"
	"time"
)

// Response is the response from the SSLChecker function
// DomainName can be a list of SANs for a matching certificate
// IsValid will only be set to true if tls.Dial can verify the connection
// DaysUntilExpiration will be 0 if IsValid is false
type Response struct {
	DomainName          []string `json:"domain_name"`
	IsValid             bool     `json:"is_valid"`
	DaysUntilExpiration int      `json:"days_until_expiration"`
}

// SSLChecker checks the SSL certificate for a given host
func SSLChecker(host string) (Response, error) {
	var resp Response

	conn, err := tls.Dial("tcp", net.JoinHostPort(host, "443"), nil)
	if err != nil {
		return resp, err
	}

	// tls.Dial proves the connection is valid when an error is nil
	resp.IsValid = true

	// Ensure the connection is closed
	defer func() {
		_ = conn.Close()
	}()

	// Find matching certificate and calculate days until expiration
	for _, cert := range conn.ConnectionState().PeerCertificates {
		if err = cert.VerifyHostname(host); err != nil {
			continue
		}
		resp.DomainName = append(resp.DomainName, cert.DNSNames...)
		resp.DaysUntilExpiration = int(cert.NotAfter.Sub(time.Now()).Hours() / 24)
	}

	return resp, nil
}
