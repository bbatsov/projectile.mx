package invoice

import "github.com/acme/billing/tax"

// Line is a single item on an invoice.
type Line struct {
	Description string
	Quantity    int
	UnitPrice   float64
}

// Invoice collects the lines billed to a customer.
type Invoice struct {
	Customer string
	Lines    []Line
}

// Subtotal is the invoice total before tax.
func (inv Invoice) Subtotal() float64 {
	total := 0.0
	for _, l := range inv.Lines {
		total += float64(l.Quantity) * l.UnitPrice
	}
	return total
}

// Total is the invoice total including tax.
func (inv Invoice) Total(region string) float64 {
	return tax.ApplyRate(inv.Subtotal(), region)
}
