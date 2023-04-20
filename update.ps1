Import-Module au

$currentPath = (Split-Path $MyInvocation.MyCommand.Definition)
$toolsPath = Join-Path -Path $currentPath -ChildPath 'tools'

function global:au_BeforeUpdate ($Package) {
    Get-RemoteFiles -Purge -NoSuffix -Algorithm sha256

    if (!(Test-Path -Path "$env:PROGRAMFILES\Mozilla Firefox\firefox.exe")) {
        choco install firefox -y
    }

    $seleniumModuleName = 'Selenium'
    if (!(Get-Module -ListAvailable -Name $seleniumModuleName)) {
        Install-Module -Name $seleniumModuleName
    }
    Import-Module $seleniumModuleName

    $startUrl = "https://web.archive.org/save/$($Latest.Url32)"
    Write-Host "Starting Selenium at $startUrl"
    $seleniumDriver = Start-SeFirefox -StartURL $startUrl -Headless
    $Latest.ArchivedURL = $seleniumDriver.Url
    $seleniumDriver.Dispose()

    Copy-Item -Path "$toolsPath\VERIFICATION.txt.template" -Destination "$toolsPath\VERIFICATION.txt" -Force

    Set-DescriptionFromReadme -Package $Package -ReadmePath ".\DESCRIPTION.md"
}

function global:au_AfterUpdate ($Package) {

}

function global:au_SearchReplace {
    @{
        'build.ps1'                     = @{
            '(^\s*Url32\s*=\s*)(''.*'')' = "`$1'$($Latest.ArchivedURL)'"
        }
        "$($Latest.PackageName).nuspec" = @{
            "<packageSourceUrl>[^<]*</packageSourceUrl>" = "<packageSourceUrl>https://github.com/brogers5/chocolatey-package-$($Latest.PackageName)/tree/v$($Latest.Version)</packageSourceUrl>"
            "<copyright>[^<]*</copyright>"               = "<copyright>Copyright © Microsoft 2009-$(Get-Date -Format yyyy)</copyright>"
        }
        'tools\VERIFICATION.txt'        = @{
            '%snapshotUrl%'   = "$($Latest.ArchivedURL)"
            '%checksumType%'  = "$($Latest.ChecksumType32.ToUpper())"
            '%checksumValue%' = "$($Latest.Checksum32)"
        }
    }
}

function global:au_GetLatest {
    #Use filename with .zip extension to prevent issues with Expand-Archive in Windows PowerShell
    $tempArchive = "$(New-TemporaryFile).zip"
    $downloadUri = 'https://dlaa.me/Samples/Insomnia/Insomnia.zip'
    $userAgent = 'Update checker of Chocolatey Community Package ''insomnia-dotnet'''
    Invoke-WebRequest -Uri $downloadUri -UserAgent $userAgent -OutFile $tempArchive -UseBasicParsing

    $tempDirectory = Join-Path -Path $env:TEMP -ChildPath $(New-Guid)
    Expand-Archive -Path $tempArchive -DestinationPath $tempDirectory -Force
    $dotNetBinaryPath = Join-Path -Path $tempDirectory -ChildPath '.NET' | Join-Path -ChildPath 'Insomnia.exe'
    $dotNetBinary = Get-Item -Path $dotNetBinaryPath
    $softwareVersion = $dotNetBinary.VersionInfo.ProductVersion

    Remove-Item -Path $tempDirectory -Recurse -Force 
    Remove-Item -Path $tempArchive -Force

    return @{
        Url32   = $downloadUri
        Version = $softwareVersion
    }
}

Update-Package -ChecksumFor None -NoReadme
