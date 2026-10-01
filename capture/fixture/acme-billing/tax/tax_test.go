package tax

import "testing"

func TestApplyRate(t *testing.T) {
	if got := ApplyRate(100, "DE"); got != 119 {
		t.Fatalf("ApplyRate() = %v, want 119", got)
	}
}
