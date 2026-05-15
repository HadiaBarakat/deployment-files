$FILE_URL = "https://raw.githubusercontent.com/HadiaBarakat/deployment-files/main/package.zip"


$CleanURL = ($FILE_URL -split '\?')[0]
$FileName = [System.IO.Path]::GetFileName($CleanURL)
$DestDir = "C:\NGID_Tools"

New-Item -ItemType Directory -Force -Path $DestDir | Out-Null

$DestFile = "$DestDir\$FileName"

Write-Host "Downloading $FileName..."

$download = Measure-Command {
	curl.exe -L --retry 3 --retry-delay 5 -o $DestFile $FILE_URL
}

Write-Host "Extracting..."

$extract = Measure-Command {
	Expand-Archive -Path $DestFile -DestinationPath $DestDir -Force
}

Write-Host "Done! Files extracted to $DestDir"

Write-Host "Download: $($download.TotalMilliseconds) ms"
Write-Host "Extract:  $($extract.TotalMilliseconds) ms"