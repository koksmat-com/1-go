<#---
title: Report Rooms created
connection: sharepoint
input: rooms.created.json
tag: report-rooms-created
---


#>


$roomCreated = Get-Content "$env:WORKDIR/rooms.created.json" | ConvertFrom-Json


Connect-PnPOnline -Url $ENV:SITEURL  -ClientId $PNPAPPID -Tenant $PNPTENANTID -CertificatePath "$PNPCERTIFICATEPATH"

foreach ($room in $roomCreated) {
  
    Set-PnPListItem -List Rooms -Identity $room.ID -Values @{
        "Email"                     = $room.Email
        "Provisioning_x0020_Status" = "Provisioned"
    }

}

$result = "SharePoint updated"
