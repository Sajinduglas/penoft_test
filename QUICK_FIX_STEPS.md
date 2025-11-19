# Quick Fix for Google Sign-In Error Code 10

## The Problem
Your `strings.xml` still has the placeholder `YOUR_WEB_CLIENT_ID_HERE`. You need to:
1. Get your SHA-1 fingerprint
2. Create an OAuth Client ID in Google Cloud Console
3. Update `strings.xml` with the real Client ID
4. Add SHA-1 to the OAuth Client

## Step 1: Get Your SHA-1 Fingerprint

**Option A: Using Gradle (Recommended)**
```powershell
cd android
.\gradlew signingReport
```
Look for the output section that shows:
```
Variant: debug
Config: debug
SHA1: AA:BB:CC:DD:EE:FF:... (copy this value)
```

**Option B: Using Keytool**
```powershell
keytool -list -v -keystore "$env:USERPROFILE\.android\debug.keystore" -alias androiddebugkey -storepass android -keypass android
```
Look for the line: `SHA1: AA:BB:CC:DD:EE:FF:...` and copy it.

## Step 2: Set Up Google Cloud Console

1. **Go to:** https://console.cloud.google.com/
2. **Create or select a project**
3. **Enable APIs:**
   - Go to "APIs & Services" → "Library"
   - Search for "Google Sign-In API" or "Google+ API"
   - Click "Enable"

4. **Configure OAuth Consent Screen:**
   - Go to "APIs & Services" → "OAuth consent screen"
   - Choose "External" (unless you have Google Workspace)
   - Fill in:
     - App name: Your app name
     - User support email: Your email
     - Developer contact: Your email
   - Click "Save and Continue"
   - Add scopes: `email`, `profile`, `openid`
   - Click "Save and Continue" (skip test users for now)
   - Click "Back to Dashboard"

5. **Create OAuth Client ID:**
   - Go to "APIs & Services" → "Credentials"
   - Click "+ CREATE CREDENTIALS" → "OAuth client ID"
   - Application type: **Web application**
   - Name: "Your App Web Client"
   - Authorized redirect URIs: (leave empty or add your backend URL)
   - Click "CREATE"
   - **COPY THE CLIENT ID** (looks like: `123456789-abcdefghijklmnop.apps.googleusercontent.com`)

6. **Add Android Configuration:**
   - Still in the Credentials page, click on the OAuth Client ID you just created
   - Scroll down to "Android" section
   - Click "ADD PACKAGE NAME AND FINGERPRINT"
   - Package name: `com.example.penoft_machine_test`
   - SHA-1 certificate fingerprint: Paste your SHA-1 from Step 1
   - Click "SAVE"

## Step 3: Update Your App

1. **Open:** `android/app/src/main/res/values/strings.xml`
2. **Replace** `YOUR_WEB_CLIENT_ID_HERE` with your actual Client ID from Step 2.5
3. **Save the file**

Example:
```xml
<string name="default_web_client_id">123456789-abcdefghijklmnop.apps.googleusercontent.com</string>
```

## Step 4: Rebuild and Test

```powershell
flutter clean
flutter pub get
flutter run
```

## Important Notes

- ⚠️ **Wait 5-10 minutes** after adding SHA-1 fingerprint for changes to propagate
- ⚠️ Make sure you're using the **Web application** Client ID, not Android Client ID
- ⚠️ The package name must match exactly: `com.example.penoft_machine_test`
- ⚠️ If you have a release keystore, add that SHA-1 too

## Still Not Working?

1. Double-check the Client ID in `strings.xml` matches the Web Client ID
2. Verify SHA-1 is added correctly (no extra spaces)
3. Wait a few more minutes and try again
4. Check Google Cloud Console → Credentials → Your OAuth Client → Android section shows your package name and SHA-1


