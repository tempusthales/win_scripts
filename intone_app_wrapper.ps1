# Created by: Tempus Thales
# Run this script from your $HOME folder

git clone https://github.com/microsoft/Microsoft-Win32-Content-Prep-Tool $HOME/Intune

Remove-Item $env:TEMP -Force -Recurse -ErrorAction SilentlyContinue

Function Get-FileName($initialDirectory)
{
    Add-Type -AssemblyName System.Windows.Forms
    $OpenFileDialog = New-Object System.Windows.Forms.OpenFileDialog
    $OpenFileDialog.Title = "Please Select File"
    $OpenFileDialog.InitialDirectory = $initialDirectory
    $OpenFileDialog.filter = "All files (*.*)| *.*"
    # Out-Null supresses the "OK" after selecting the file.
    $OpenFileDialog.ShowDialog() | Out-Null
    $Global:SelectedFile = $OpenFileDialog.FileName
    $Global:SelectedFilePath = split-path -path $SelectedFile
    $Global:SelectedFileName = [System.IO.Path]::GetFileName("$SelectedFile")
}

Get-FileName
echo $SelectedFile
echo $SelectedFilePath
echo $SelectedFileName 

Start-Process $HOME\Intune\IntuneWinAppUtil.exe "-c $SelectedFilePath -s $SelectedFileName -o $SelectedFilePath" -Wait 
