
function getDrive(){
    try{
        $drive = Get-Volume -FriendlyName Photos
        Write-Host $drive.DriveLetter
        return $drive.DriveLetter
    }
    catch{
        Write-Error "Failed to get Drive: $_"
        return $null
    }
}

function sources($drive) {
    return @{
        scans =  $drive + ":\Kroll Family Scans"
        upc =  $drive + ":\THE Ultimate Collection"
        d1 = '\\192.168.1.228\Share\b_photos\upc'
        d2 = '\\192.168.1.228\Share\b_photos\kroll'
    }
}
function runIt($data) {
    $jobs = @(
        Start-Job -ScriptBlock { param($src, $dst) robocopy $src $dst /MIR /XO /NP /Z /LOG+:backup_log.txt } -ArgumentList $data.scans, $data.d2
        Start-Job -ScriptBlock { param($src, $dst) robocopy $src $dst /MIR /XO /NP /Z /LOG+:backup_log.txt } -ArgumentList $data.upc, $data.d1
    )
    $jobs | Wait-Job
    $jobs | Receive-Job
    $jobs | Remove-Job
}
function disableUSB($drive){
    $driveEject = New-Object -comObject Shell.Application
    $driveEject.Namespace(17).ParseName($drive).InvokeVerb("Eject")
}
function bedTime(){
    $PowerState = [System.Windows.Forms.PowerState]::Suspend;
    $Force = $true
    $DisableWake = $false
    try{
        [System.Windows.Forms.Application]::SetSuspendState($PowerState,$Force,$DisableWake)
    }
    catch{
        Write-Error "Failed to suspend computer properly: $_"
        Stop-Computer -ComputerName localhost -Force
    }
}
$drive = getDrive
if ($drive){
    $known = sources($drive)
    Write-Host $known.scans
    runIt($known)
    disableUSB($drive)
    bedTime
}
else{
    Write-Error "Drive Not Found. Aborting"
}