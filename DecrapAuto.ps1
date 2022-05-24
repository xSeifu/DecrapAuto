#This is for helping to automate Decrapifier when fresh installing Windows 10

$mydrive=(GWmi Win32_LogicalDisk | Where-Object{$_.VolumeName -eq 'Name_of_Drive'} | ForEach-Object{$_.DeviceID})
$Eject = New-Object -ComObject Shell.Application
#mydrive is for obtaining the name of the flash drive in order to transfer data
#Eject will be used to eject the drive once complete

If ( -not ( Test-Path c:\temp.x ) )
{
     New-Item -ItemType "directory" -Path "c:\temp.x"
     ForEach-Object{Copy-Item "$mydrive\Decrapifier\location" -Destination "c:\temp.x" -Recurse}
}
Else
{
    ForEach-Object{Copy-Item "$mydrive\Decrapifier\location" -Destination "c:\temp.x" -Recurse}
}

$Eject.NameSpace(17).ParseName($mydrive).InvokeVerb("Eject")

Set-Location C:\temp.x\Decrapifier\location

& '.\Name_of_Decrapifier_File.ps1' -cortana -tablet

If ( (Get-ExecutionPolicy -scope LocalMachine) -ne "Restriced" )
{
    Set-ExecutionPolicy Restricted -Force
}

Write-Output "This computer has been Decrapified! Current ExecutionPolicy status:"
Get-ExecutionPolicy

#Option for deleting this ps1 file after use
#Write-Output "Deleting DecrapAuto.ps1..."
#Remove-Item $PSCommandPath -Force 
