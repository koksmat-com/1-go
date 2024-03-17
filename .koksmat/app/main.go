package main

import (
	"runtime/debug"
	"strings"

	"github.com/365admin/1-go/magicapp"
)

func main() {
	info, _ := debug.ReadBuildInfo()

	// split info.Main.Path by / and get the last element
	s1 := strings.Split(info.Main.Path, "/")
	name := s1[len(s1)-1]
	description := `---
title: 1-go
description: Describe the main purpose of this kitchen
---

# 

# 1-go

![](2024-03-05-18-19-26.png)`
	magicapp.Setup(".env")
	magicapp.RegisterServeCmd("1-go", description, "0.0.1", 8080)
	magicapp.RegisterCmds()
	magicapp.Execute(name, "1-go", "")
}
