package main

import (
	"fmt"
	"os"
)

func main() {
	fmt.Printf("Hello, world!\n%s\n%s\n", os.Args[1], os.Args[2])
}
