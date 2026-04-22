# Run this once (as your normal user, no admin needed) to register the scheduled task.
# After that, check-office.ps1 will run automatically every time you log in.

$scriptPath = Join-Path $PSScriptRoot 'check-office.ps1'

$action = New-ScheduledTaskAction `
    -Execute 'powershell.exe' `
    -Argument "-WindowStyle Hidden -NonInteractive -ExecutionPolicy Bypass -File `"$scriptPath`""

$trigger = New-ScheduledTaskTrigger -AtLogOn -User $env:USERNAME

$settings = New-ScheduledTaskSettingsSet `
    -ExecutionTimeLimit (New-TimeSpan -Minutes 2) `
    -MultipleInstances IgnoreNew `
    -StartWhenAvailable

Register-ScheduledTask `
    -TaskName  'Office WiFi Auto Check-in' `
    -TaskPath  '\' `
    -Action    $action `
    -Trigger   $trigger `
    -Settings  $settings `
    -RunLevel  Limited `
    -Force | Out-Null

Write-Host "Task registered. It will run at every login." -ForegroundColor Green
Write-Host "To test it now, run: & '$scriptPath'" -ForegroundColor Cyan
