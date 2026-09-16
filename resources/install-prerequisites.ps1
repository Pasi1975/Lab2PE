[CmdletBinding()]
param()

$ErrorActionPreference = 'Stop'

if ($PSVersionTable.PSVersion.Major -lt 5) {
    throw 'This script requires Windows PowerShell 5.1 or PowerShell 7.'
}

if (-not (Get-Command winget.exe -ErrorAction SilentlyContinue)) {
    throw 'WinGet was not found. Install or update App Installer from the Microsoft Store, then run this script again.'
}

$packages = @(
    'GitHub.Copilot'
    'GitHub.CopilotApp'
    'Microsoft.PowerBI'
    'Microsoft.VisualStudioCode'
    'OpenJS.NodeJS.LTS'
    'Microsoft.AzureCLI'
    'Git.Git'
)

$results = foreach ($package in $packages) {
    Write-Host "`nInstalling $package..." -ForegroundColor Cyan

    $arguments = @(
        'install'
        '--exact'
        '--id', $package
        '--source', 'winget'
        '--silent'
        '--disable-interactivity'
        '--accept-source-agreements'
        '--accept-package-agreements'
    )

    & winget.exe @arguments
    $exitCode = $LASTEXITCODE

    if ($exitCode -eq 0) {
        $status = 'Success'
    }
    elseif ($exitCode -eq -1978335189) {
        $status = 'Already current'
    }
    else {
        $status = 'Failed'
    }

    [PSCustomObject]@{
        Package  = $package
        Status   = $status
        ExitCode = $exitCode
    }
}

$results | Format-Table -Property Package, Status, ExitCode -AutoSize

$failedCount = @($results | Where-Object { $_.Status -eq 'Failed' }).Count

if ($failedCount -gt 0) {
    Write-Host "`n$failedCount package installation(s) failed. Review the console output above for details." -ForegroundColor Red
    exit 1
}

Write-Host 'All package installations completed successfully.' -ForegroundColor Green
exit 0