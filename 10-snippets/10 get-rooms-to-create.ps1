<#---
title: Get Rooms to create
connection: sharepoint
output: rooms.create.json
tag: get-rooms-to-create
hook: meeting-infrastructure-exchange
---

## A file is extract from SharePoint containing the rooms to be created

#>
$result = "$env:WORKDIR/rooms.create.json"

Connect-PnPOnline -Url $ENV:SITEURL  -ClientId $PNPAPPID -Tenant $PNPTENANTID -CertificatePath "$PNPCERTIFICATEPATH"

$listItems = Get-PnpListItem -List Rooms  | Where-Object { $_.FieldValues.Provisioning_x0020_Status -eq "Provision" }

write-host "Rooms in list: $($listItems.Count)"
$roomsToCreate = @()
foreach ($room in $listItems) {
    $room = @{
        ID = $room.FieldValues.ID
        Title = $room.FieldValues.Title
        Capacity = $room.FieldValues.Capacity
        RestrictedToPeople = $room.FieldValues.RestrictedToPeople
    }
    $roomsToCreate += $room
   
}

$roomsToCreate | ConvertTo-Json -Depth 10 | Out-File -FilePath $result -Encoding utf8NoBOM
