package invoice

import "testing"

func TestSubtotal(t *testing.T) {
	inv := Invoice{Lines: []Line{{"Widget", 2, 10}, {"Gadget", 1, 5.5}}}
	if got := inv.Subtotal(); got != 25.5 {
		t.Fatalf("Subtotal() = %v, want 25.5", got)
	}
}

func TestTotal(t *testing.T) {
	inv := Invoice{Lines: []Line{{"Widget", 1, 100}}}
	if got := inv.Total("BG"); got != 120 {
		t.Fatalf("Total() = %v, want 120", got)
	}
}
