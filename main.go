package main

import (
	"flag"
	"fmt"

	"github.com/google/uuid"
)

var version string
var showVersion bool

func main() {
	flag.BoolVar(&showVersion, "version", false, "show version")
	flag.Parse()
	if showVersion {
		fmt.Println(version)
	} else {
		fmt.Println(uuid.NewString())
	}
}
