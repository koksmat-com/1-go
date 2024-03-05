<#---
title: Get .koksmat directory
---#>

if ((Split-Path -Leaf (Split-Path  -Parent -Path $PSScriptRoot)) -eq "sessions"){
    $koksmatDir = join-path $PSScriptRoot ".." ".."
}
else{
  $koksmatDir = join-path $PSScriptRoot ".." ".koksmat/"

}

Write-Host "koksmatDir: $koksmatDir"