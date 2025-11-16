# Google Sign-In Setup Guide

## Error Code 10 (DEVELOPER_ERROR) - Solution

This error occurs when Google Sign-In is not properly configured. Follow these steps to fix it:

## Step 1: Get Your SHA-1 Fingerprint

You need to get your app's SHA-1 fingerprint and add it to Firebase Console.

### For Debug Build:
```bash
cd android
./gradlew signingReport
```

Look for the SHA-1 fingerprint under `Variant: debug` → `Config: debug` → `SHA1:`

**OR** use this command:
```bash
keytool -list -v -keystore "%USERPROFILE%\.android\debug.keystore" -alias androiddebugkey -storepass android -keypass android
```

Copy the SHA-1 value (it looks like: `AA:BB:CC:DD:EE:FF:...`)

### For Release Build:
If you have a release keystore:
```bash
keytool -list -v -keystore "path/to/your/keystore.jks" -alias your-key-alias
```

## Step 2: Set Up Firebase Project

1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Create a new project or select an existing one
3. Click "Add app" → Select Android
4. Enter your package name: `com.example.penoft_machine_test`
5. Register the app
6. **Download `google-services.json`** file
7. Place it in: `android/app/google-services.json`

## Step 3: Add SHA-1 to Firebase

1. In Firebase Console, go to **Project Settings** (gear icon)
2. Scroll down to "Your apps" section
3. Click on your Android app
4. Click "Add fingerprint"
5. Paste your SHA-1 fingerprint (from Step 1)
6. Click "Save"

**Important:** You need to add BOTH debug and release SHA-1 fingerprints if you plan to release the app.

## Step 4: Enable Google Sign-In in Firebase

1. In Firebase Console, go to **Authentication**
2. Click "Get started" (if not already enabled)
3. Go to "Sign-in method" tab
4. Click on "Google"
5. Enable it and set your support email
6. Click "Save"

## Step 5: Verify Configuration

After adding `google-services.json`, the `strings.xml` file will be automatically populated with the correct OAuth Client ID.

## Step 6: Rebuild Your App

```bash
flutter clean
flutter pub get
flutter run
```

## Alternative: Manual OAuth Client ID Configuration (Without Firebase)

If you don't want to use Firebase, you can configure OAuth Client ID manually:

1. Go to [Google Cloud Console](https://console.cloud.google.com/)
2. Create a new project or select existing
3. Enable "Google Sign-In API" (or "Google+ API")
4. Go to "Credentials" → "Create Credentials" → "OAuth client ID"
5. **First, configure OAuth consent screen:**
   - Go to "OAuth consent screen"
   - Choose "External" (unless you have a Google Workspace)
   - Fill in required fields (App name, User support email, Developer contact)
   - Add scopes: `email`, `profile`, `openid`
   - Save and continue
6. **Create OAuth Client ID:**
   - Application type: **Web application**
   - Name: Your app name
   - Authorized redirect URIs: (leave empty for now, or add your backend URL if needed)
   - Click "Create"
7. **Copy the Client ID** (it looks like: `123456789-abcdefghijklmnop.apps.googleusercontent.com`)
8. **Update `android/app/src/main/res/values/strings.xml`:**
   ```xml
   <string name="default_web_client_id">YOUR_CLIENT_ID_HERE</string>
   ```
   Replace `YOUR_CLIENT_ID_HERE` with the Client ID you copied
9. **Get your SHA-1 fingerprint** (see Step 1 above)
10. **Add SHA-1 to OAuth Client:**
    - Go back to "Credentials" in Google Cloud Console
    - Click on your OAuth 2.0 Client ID
    - Under "Android", click "Add package name and fingerprint"
    - Package name: `com.example.penoft_machine_test`
    - SHA-1: Paste your SHA-1 fingerprint
    - Click "Save"

## Troubleshooting

- **Error persists?** Make sure you've:
  - Added the SHA-1 fingerprint to Firebase/Google Cloud Console
  - Placed `google-services.json` in the correct location (`android/app/`)
  - Rebuilt the app after making changes
  - Waited a few minutes after adding SHA-1 (it can take time to propagate)

- **Still not working?** Try:
  ```bash
  flutter clean
  cd android
  ./gradlew clean
  cd ..
  flutter pub get
  flutter run
  ```

## Files Modified

The following files have been updated:
- `android/build.gradle` - Added Google Services plugin
- `android/app/build.gradle` - Applied Google Services plugin
- `android/app/src/main/res/values/strings.xml` - Created for OAuth Client ID

