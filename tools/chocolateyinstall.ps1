$ErrorActionPreference = 'Stop'

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$extractedDirectory = '.NET'
$extractedArchivePath = Join-Path -Path $toolsDir -ChildPath 'Insomnia.zip'
$packageArgs = @{
  fileFullPath   = $extractedArchivePath
  specificFolder = $extractedDirectory
  destination    = $toolsDir
  packageName    = $env:ChocolateyPackageName
}
Get-ChocolateyUnzip @packageArgs

#Clean up ZIP archive post-extraction to prevent unnecessary disk bloat
Remove-Item -Path $extractedArchivePath -Force -ErrorAction SilentlyContinue

$binaryFileName = 'Insomnia.exe'
$binaryDirectoryPath = Join-Path -Path $toolsDir -ChildPath $extractedDirectory

$pp = Get-PackageParameters
if ($pp.NoShim)
{
  #Create shim ignore file
  $ignoreFilePath = Join-Path -Path $binaryDirectoryPath -ChildPath "$binaryFileName.ignore"
  Set-Content -Path $ignoreFilePath -Value $null -ErrorAction SilentlyContinue
}
else
{
  #Create GUI shim
  $guiShimPath = Join-Path -Path $binaryDirectoryPath -ChildPath "$binaryFileName.gui"
  Set-Content -Path $guiShimPath -Value $null -ErrorAction SilentlyContinue
}

$linkName = 'Insomnia (.NET).lnk'
$targetPath = Join-Path -Path $binaryDirectoryPath -ChildPath $binaryFileName
if (!$pp.NoDesktopShortcut)
{
  $desktopDirectory = [Environment]::GetFolderPath([Environment+SpecialFolder]::DesktopDirectory)
  $shortcutFilePath = Join-Path -Path $desktopDirectory -ChildPath $linkName
  Install-ChocolateyShortcut -ShortcutFilePath $shortcutFilePath -TargetPath $targetPath -ErrorAction SilentlyContinue
}

if (!$pp.NoProgramsShortcut)
{
  $programsDirectory = [Environment]::GetFolderPath([Environment+SpecialFolder]::Programs)
  $shortcutFilePath = Join-Path -Path $programsDirectory -ChildPath $linkName
  Install-ChocolateyShortcut -ShortcutFilePath $shortcutFilePath -TargetPath $targetPath -ErrorAction SilentlyContinue
}

if ($pp.Start)
{
  try
  {
    Start-Process -FilePath $targetPath -ErrorAction Continue
  }
  catch
  {
    Write-Warning "$softwareName failed to start, please try to manually start it instead."
  }
}
