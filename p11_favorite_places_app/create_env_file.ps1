Write-Host "Creating .env file for Google Maps API key..." -ForegroundColor Green
Write-Host ""

$apiKey = Read-Host "Please enter your Google Maps API key"

if ($apiKey -and $apiKey.Trim() -ne "") {
    "GOOGLE_MAPS_API_KEY=$apiKey" | Out-File -FilePath ".env" -Encoding UTF8
    Write-Host ".env file created successfully!" -ForegroundColor Green
    Write-Host ""
    Write-Host "Next steps:" -ForegroundColor Yellow
    Write-Host "1. Make sure your API key has the following APIs enabled:" -ForegroundColor White
    Write-Host "   - Maps Static API" -ForegroundColor White
    Write-Host "   - Geocoding API" -ForegroundColor White
    Write-Host "2. Run 'flutter pub get' to ensure dependencies are up to date" -ForegroundColor White
    Write-Host "3. Restart your Flutter app" -ForegroundColor White
} else {
    Write-Host "No API key provided. .env file not created." -ForegroundColor Red
}

Write-Host ""
Read-Host "Press Enter to continue"
