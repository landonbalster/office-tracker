# Checks whether the machine is connected to the Thomson Reuters office WiFi.
# If so, opens the office tracker with ?auto=1 so today is marked automatically.

$officeNetwork = 'ead.thomsonreuters.com'
$profile = Get-NetConnectionProfile -InterfaceAlias 'Wi-Fi' -ErrorAction SilentlyContinue

if ($profile -and $profile.Name -eq $officeNetwork) {
    $htmlPath = Join-Path $PSScriptRoot 'office-tracker.html'
    if (Test-Path $htmlPath) {
        # Build a file:// URL with the auto-checkin flag
        $escaped = $htmlPath.Replace('\', '/').Replace(' ', '%20')
        $url = "file:///$escaped`?auto=1"
        Start-Process $url
    }
}
