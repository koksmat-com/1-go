<#---
title: Get Worddir
---#>

if ($env:WORKDIR -eq $null) {
    $env:WORKDIR = "$psscriptroot/../.koksmat/workdir"
}
$workdir =  $env:WORKDIR

if (-not (Test-Path $workdir)) {
    $x = New-Item -Path $workdir -ItemType Directory 
}

write-host "Workdir: $workdir"