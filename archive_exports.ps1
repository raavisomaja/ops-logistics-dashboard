# Archive Ops-Logistics CSV exports into a dated folder

$sourceFolder = "$HOME/Documents/Projects/ops-logistics"
$archiveRoot = "$sourceFolder/archive"
$dateStamp = Get-Date -Format "yyyy-MM-dd"
$archiveFolder = "$archiveRoot/$dateStamp"

# Create the dated archive folder if it doesn't exist
if (-not (Test-Path $archiveFolder)) {
    New-Item -ItemType Directory -Path $archiveFolder -Force | Out-Null
    Write-Host "Created archive folder: $archiveFolder"
}

# Find all CSV exports in the source folder (not already archived)
$csvFiles = Get-ChildItem -Path $sourceFolder -Filter "*.csv" -File

if ($csvFiles.Count -eq 0) {
    Write-Host "No CSV files found to archive."
} else {
    foreach ($file in $csvFiles) {
        $destination = Join-Path $archiveFolder $file.Name
        Copy-Item -Path $file.FullName -Destination $destination -Force
        Write-Host "Archived: $($file.Name) -> $archiveFolder"
    }
    Write-Host "`nDone. $($csvFiles.Count) file(s) archived to $archiveFolder"
}
