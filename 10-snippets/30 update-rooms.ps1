<#---
title: Update Rooms
input: rooms.update.json
connection: exchange
output: rooms.updated.json
tag: update-rooms
---

TODO: Support change of email address
https://c7solutions.com/2019/08/making-your-office-365-meeting-rooms-accessible
#>


function UpdateRoomStandard
 (
    [Parameter(Mandatory = $true)]
    [string]$Mail

)
{
    Set-Mailbox $Mail  -MailTip ""
    Set-CalendarProcessing $Mail  -DeleteComments $false -AutomateProcessing AutoAccept  -AllBookInPolicy:$true -BookInPolicy $null -BookingWindowInDays 601     
}

function UpdateRoomRestricted
 (
    [Parameter(Mandatory = $true)]
    [string]$Mail,
    [Parameter(Mandatory = $true)]
    [string[]]$RestrictedTo,
    [Parameter(Mandatory = $true)]
    [string]$MailTip

)
{
    Set-Mailbox $Mail  -MailTip $MailTip
    $r = $RestrictedTo.Split(",") 
    Set-CalendarProcessing $mail  -DeleteComments $false -AutomateProcessing AutoAccept -AllRequestInPolicy $false  -AllBookInPolicy $false -BookInPolicy $r -BookingWindowInDays 601 -ResourceDelegates $null       
  
}


$rooms = Get-Content "$env:WORKDIR/rooms.update.json" | ConvertFrom-Json

$roomsUpdated = @(

)

foreach ($room in $rooms) {
    Set-Mailbox -Identity $room.Email -DisplayName $room.Title   -Confirm:$false
    $capacity = [int]::Parse( $room.Capacity)
    Set-Place -Identity $room.Email -Capacity  $capacity  

    if ($null -eq $room.RestrictedTo) {
        UpdateRoomStandard -Mail $room.Email 
    }
    else {
        UpdateRoomRestricted -Mail $room.Email -RestrictedTo $room.RestrictedTo -MailTip "Restricted booking"
    }
    $response = @{
        ID = $room.ID
    
    }
    $roomsUpdated += $response
}


$result = "$env:WORKDIR/rooms.updated.json"

$roomsUpdated | ConvertTo-Json -Depth 10 | Out-File -FilePath $result -Encoding utf8NoBOM

