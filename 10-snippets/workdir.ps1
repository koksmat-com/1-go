<#---
title: Get Workdir
---#>

if ($env:WORKDIR -eq $null) {
    $env:WORKDIR = join-path $psscriptroot ".." ".koksmat" "workdir"
}
$workdir =  $env:WORKDIR

if (-not (Test-Path $workdir)) {
    $x = New-Item -Path $workdir -ItemType Directory 
}

$workdir = Resolve-Path $workdir

write-host "Workdir: $workdir"