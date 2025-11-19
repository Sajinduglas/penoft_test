# 🚨 THE PROBLEM - CLEAR EXPLANATION

## What's Wrong:

**Error Code 10 = DEVELOPER_ERROR**

Your `android/app/src/main/res/values/strings.xml` file has this:
```xml
<string name="default_web_client_id">YOUR_WEB_CLIENT_ID_HERE</string>
```

This is a **PLACEHOLDER**, not a real OAuth Client ID. Google Sign-In **CANNOT WORK** with a placeholder.

## Why This Happens:

Google Sign-In needs:
1. ✅ A valid OAuth Client ID (Web application type) from Google Cloud Console
2. ✅ Your app's SHA-1 fingerprint registered with that Client ID
3. ✅ The Client ID must be in `strings.xml` as `default_web_client_id`

**You currently have NONE of these configured.**

---

# ✅ THE SOLUTION - STEP BY STEP

## STEP 1: Get Your SHA-1 Fingerprint

**Run this command:**
```powershell
cd android
.\gradlew signingReport
```

**Look for this in the output:**
```
Variant: debug
Config: debug
Store: C:\Users\amosp\.android\debug.keystore
Alias: AndroidDebugKey
SHA1: XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX
```

**COPY THE SHA1 VALUE** (the part after "SHA1: ")

---

## STEP 2: Create OAuth Client ID in Google Cloud Console

### 2.1 Go to Google Cloud Console
👉 https://console.cloud.google.com/

### 2.2 Create or Select a Project
- Click the project dropdown at the top
- Click "NEW PROJECT" or select existing
- Give it a name (e.g., "My Flutter App")
- Click "CREATE"

### 2.3 Enable Google Sign-In API
- Go to "APIs & Services" → "Library" (left sidebar)
- Search for "Google Sign-In API"
- Click on it
- Click "ENABLE"

### 2.4 Configure OAuth Consent Screen
- Go to "APIs & Services" → "OAuth consent screen"
- Choose "External" (unless you have Google Workspace)
- Click "CREATE"
- Fill in:
  - App name: `Penoft Machine Test` (or any name)
  - User support email: **YOUR EMAIL**
  - Developer contact: **YOUR EMAIL**
- Click "SAVE AND CONTINUE"
- On "Scopes" page, click "SAVE AND CONTINUE" (default scopes are fine)
- On "Test users" page, click "SAVE AND CONTINUE" (skip for now)
- Click "BACK TO DASHBOARD"

### 2.5 Create OAuth Client ID
- Go to "APIs & Services" → "Credentials"
- Click "+ CREATE CREDENTIALS" → "OAuth client ID"
- Application type: **Select "Web application"** ⚠️ IMPORTANT: Must be WEB, not Android!
- Name: `Web Client for Android App`
- Authorized redirect URIs: (leave empty)
- Click "CREATE"
- **A popup will show your Client ID** - **COPY IT NOW!**
  - It looks like: `123456789-abcdefghijklmnopqrstuvwxyz.apps.googleusercontent.com`
- Click "OK"

### 2.6 Add Android Configuration to the OAuth Client
- Still on the Credentials page, find the OAuth Client ID you just created
- Click on it (the name, not the copy icon)
- Scroll down to find "Android" section
- Click "ADD PACKAGE NAME AND FINGERPRINT"
- Package name: `com.example.penoft_machine_test` (exactly this, no spaces)
- SHA-1 certificate fingerprint: **PASTE YOUR SHA-1 FROM STEP 1**
- Click "SAVE"

---

## STEP 3: Update Your App's strings.xml

**Open this file:**
`android/app/src/main/res/values/strings.xml`

**Replace this line:**
```xml
<string name="default_web_client_id">YOUR_WEB_CLIENT_ID_HERE</string>
```

**With this (use YOUR actual Client ID from Step 2.5):**
```xml
<string name="default_web_client_id">123456789-abcdefghijklmnopqrstuvwxyz.apps.googleusercontent.com</string>
```

**SAVE THE FILE**

---

## STEP 4: Rebuild and Test

```powershell
flutter clean
flutter pub get
flutter run
```

---

## ⚠️ IMPORTANT NOTES:

1. **Wait 5-10 minutes** after adding SHA-1 fingerprint - Google needs time to process it
2. **Use WEB Client ID**, not Android Client ID
3. **Package name must match exactly**: `com.example.penoft_machine_test`
4. **SHA-1 must be correct** - no extra spaces, use colons (XX:XX:XX format)

---

## 🔍 How to Verify It's Working:

After following all steps and waiting 5-10 minutes:
- Run the app
- Try Google Sign-In
- If you see the Google account picker, it's working! ✅
- If you still get Error 10, double-check:
  - Client ID in strings.xml matches the Web Client ID
  - SHA-1 is added correctly in Google Cloud Console
  - Package name matches exactly

---

## ❌ Common Mistakes:

1. ❌ Using Android Client ID instead of Web Client ID
2. ❌ Forgetting to add SHA-1 fingerprint
3. ❌ Wrong package name
4. ❌ Not waiting for Google to process the SHA-1
5. ❌ Typo in the Client ID in strings.xml


