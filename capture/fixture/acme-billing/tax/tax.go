package tax

var rates = map[string]float64{"BG": 0.20, "DE": 0.19, "NL": 0.21}

// ApplyRate adds the region's VAT to amount.
func ApplyRate(amount float64, region string) float64 {
	return amount * (1 + rates[region])
}
