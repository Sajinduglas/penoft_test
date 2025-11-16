# PowerShell script to get SHA-1 fingerprint for Google Sign-In setup

Write-Host "Getting SHA-1 fingerprint for debug keystore..." -ForegroundColor Cyan
Write-Host ""

$keystorePath = "$env:USERPROFILE\.android\debug.keystore"

if (Test-Path $keystorePath) {
    Write-Host "Found debug keystore at: $keystorePath" -ForegroundColor Green
    Write-Host ""
    Write-Host "SHA-1 Fingerprint:" -ForegroundColor Yellow
    Write-Host "==================" -ForegroundColor Yellow
    
    keytool -list -v -keystore $keystorePath -alias androiddebugkey -storepass android -keypass android | Select-String -Pattern "SHA1:" -Context 0,0
    
    Write-Host ""
    Write-Host "Copy the SHA-1 value (the part after 'SHA1: ')" -ForegroundColor Cyan
    Write-Host "You'll need this for Google Cloud Console setup." -ForegroundColor Cyan
} else {
    Write-Host "Debug keystore not found at: $keystorePath" -ForegroundColor Red
    Write-Host "Trying alternative method with Gradle..." -ForegroundColor Yellow
    Write-Host ""
    
    if (Test-Path "android\gradlew.bat") {
        Write-Host "Running: cd android && gradlew signingReport" -ForegroundColor Cyan
        Set-Location android
        .\gradlew.bat signingReport
        Set-Location ..
    } else {
        Write-Host "Gradle wrapper not found. Please run manually:" -ForegroundColor Red
        Write-Host "  cd android" -ForegroundColor Yellow
        Write-Host "  .\gradlew signingReport" -ForegroundColor Yellow
    }
}

Write-Host ""
Write-Host "Press any key to exit..."
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")

