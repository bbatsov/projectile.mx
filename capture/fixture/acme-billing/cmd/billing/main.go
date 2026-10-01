package main

import (
	"fmt"

	"github.com/acme/billing/invoice"
)

func main() {
	inv := invoice.Invoice{Customer: "Initech", Lines: []invoice.Line{{"Consulting", 3, 150}}}
	fmt.Printf("%s owes %.2f\n", inv.Customer, inv.Total("NL"))
}
