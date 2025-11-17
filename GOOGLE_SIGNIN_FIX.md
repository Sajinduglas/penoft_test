# 🔧 Google Sign-In Error Code 10 Fix

## The Problem
Error code 10 (DEVELOPER_ERROR) means your OAuth client configuration is incomplete in Google Cloud Console.

## ✅ Solution Steps

### Step 1: Get Your SHA-1 Fingerprint

Run this command in PowerShell:
```powershell
keytool -list -v -keystore "$env:USERPROFILE\.android\debug.keystore" -alias androiddebugkey -storepass android -keypass android
```

Look for the line that says:
```
SHA1: XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX
```

**COPY THE SHA1 VALUE** (the part after "SHA1: ")

### Step 2: Go to Google Cloud Console

1. Open: https://console.cloud.google.com/
2. Select your project
3. Go to **APIs & Services** → **Credentials**
4. Find your OAuth 2.0 Client ID: `158505151760-603n6v39617s41909288pq728os3ln6q.apps.googleusercontent.com`
5. Click on it to edit

### Step 3: Add Android Configuration

1. Scroll down to the **"Android"** section
2. Click **"ADD PACKAGE NAME AND FINGERPRINT"**
3. Enter:
   - **Package name**: `com.example.penoft_machine_test`
   - **SHA-1 certificate fingerprint**: Paste the SHA-1 you copied from Step 1
4. Click **"SAVE"**

### Step 4: Verify strings.xml

Make sure `android/app/src/main/res/values/strings.xml` has:
```xml
<string name="default_web_client_id">158505151760-603n6v39617s41909288pq728os3ln6q.apps.googleusercontent.com</string>
```

✅ It's already there!

### Step 5: Rebuild and Test

1. **Clean the project:**
   ```powershell
   cd android
   .\gradlew clean
   cd ..
   ```

2. **Rebuild the app:**
   ```powershell
   flutter clean
   flutter pub get
   flutter run
   ```

## ⚠️ Important Notes

- The SHA-1 fingerprint must match exactly (including colons)
- The package name must match exactly: `com.example.penoft_machine_test`
- Changes in Google Cloud Console can take a few minutes to propagate
- Make sure you're using the **debug keystore** SHA-1 for testing
- For release builds, you'll need to add the release keystore SHA-1 as well

## 🔍 Still Not Working?

If it still doesn't work after following these steps:

1. **Double-check the SHA-1** - Make sure there are no extra spaces
2. **Wait 5-10 minutes** - Google Cloud Console changes can take time
3. **Check the OAuth consent screen** - Make sure it's configured
4. **Verify the Client ID** - Make sure it's a **Web application** type OAuth client
5. **Try uncommenting the webClientId** in `google_auth_controller.dart` and setting it explicitly

## 📝 Quick Command to Get SHA-1

If the keytool command doesn't work, try:
```powershell
cd android
.\gradlew signingReport
```

Look for the SHA1 value in the output under "Variant: debug"

