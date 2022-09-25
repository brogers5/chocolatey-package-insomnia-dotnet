$ErrorActionPreference = 'Stop'

$linkName = 'Insomnia (.NET).lnk'

$programsDirectory = [Environment]::GetFolderPath([Environment+SpecialFolder]::Programs)
$programsShortcutFilePath = Join-Path -Path $programsDirectory -ChildPath $linkName
if (Test-Path $programsShortcutFilePath) {
  Remove-Item $programsShortcutFilePath
}

$desktopDirectory = [Environment]::GetFolderPath([Environment+SpecialFolder]::DesktopDirectory)
$desktopShortcutFilePath = Join-Path -Path $desktopDirectory -ChildPath $linkName
if (Test-Path $desktopShortcutFilePath) {
  Remove-Item $desktopShortcutFilePath
}
