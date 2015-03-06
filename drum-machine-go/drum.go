// Package drum is supposed to implement the decoding of .splice drum machine files.
// See golang-challenge.com/go-challenge1/ for more information
package drum

// Pattern is the high level representation of the drum pattern contained in
// a .splice file.
type Pattern struct {
	Version string
	Tempo   float32
	Tracks  []*Track
}

// Track is the high level representation of a single instrument within a
// a .splice file Pattern.
//
// It represents timing information for
type Track struct {
	ID    uint8
	Name  string   // the name of the instrument, or "sample"
	Beats [16]Beat // grid of beat step information in 4/4 time
}

// Beat represents whether an instrument is "played" for a particular step
type Beat bool
