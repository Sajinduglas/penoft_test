# ✅ DO THIS NOW - Step by Step Checklist

## 🚨 THE PROBLEM:
Your `android/app/src/main/res/values/strings.xml` has:
```xml
<string name="default_web_client_id">YOUR_WEB_CLIENT_ID_HERE</string>
```

**This is a PLACEHOLDER. It will NEVER work until you replace it with a real Client ID.**

---

## ✅ CHECKLIST - Follow Each Step:

### [ ] STEP 1: Get Your SHA-1 Fingerprint

**Run this command:**
```powershell
cd android
.\gradlew signingReport
```

**Find this in the output:**
```
SHA1: XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX
```

**✅ Copy the SHA-1 value (the part after "SHA1: ")**

---

### [ ] STEP 2: Go to Google Cloud Console

**👉 Open:** https://console.cloud.google.com/

**✅ Did you open it?** [ ]

---

### [ ] STEP 3: Create or Select a Project

- Click the project dropdown at the top
- Click "NEW PROJECT" (or select existing)
- Enter project name: `My Flutter App` (or any name)
- Click "CREATE"

**✅ Project created/selected?** [ ]

---

### [ ] STEP 4: Enable Google Sign-In API

- In left sidebar, click "APIs & Services" → "Library"
- Search for: `Google Sign-In API`
- Click on "Google Sign-In API"
- Click "ENABLE" button

**✅ API enabled?** [ ]

---

### [ ] STEP 5: Configure OAuth Consent Screen

- Click "APIs & Services" → "OAuth consent screen" (left sidebar)
- Choose "External" → Click "CREATE"
- Fill in:
  - **App name:** `Penoft Machine Test` (or any name)
  - **User support email:** YOUR EMAIL
  - **Developer contact:** YOUR EMAIL
- Click "SAVE AND CONTINUE"
- On "Scopes" page: Click "SAVE AND CONTINUE" (default is fine)
- On "Test users" page: Click "SAVE AND CONTINUE" (skip for now)
- Click "BACK TO DASHBOARD"

**✅ OAuth consent screen configured?** [ ]

---

### [ ] STEP 6: Create OAuth Client ID

- Click "APIs & Services" → "Credentials" (left sidebar)
- Click "+ CREATE CREDENTIALS" → "OAuth client ID"
- **Application type:** Select **"Web application"** ⚠️ MUST BE WEB!
- **Name:** `Web Client for Android App`
- **Authorized redirect URIs:** (leave empty)
- Click "CREATE"
- **A popup appears with your Client ID**
- **✅ COPY THE CLIENT ID NOW!** (looks like: `123456789-xxx.apps.googleusercontent.com`)
- Click "OK"

**✅ Client ID copied?** [ ]

**Your Client ID:** `___________________________` (write it here)

---

### [ ] STEP 7: Add Android Configuration

- Still on Credentials page, find the OAuth Client ID you just created
- **Click on the NAME** (not the copy icon) to open it
- Scroll down to find "Android" section
- Click "ADD PACKAGE NAME AND FINGERPRINT"
- **Package name:** `com.example.penoft_machine_test` (copy exactly, no spaces)
- **SHA-1 certificate fingerprint:** Paste your SHA-1 from Step 1
- Click "SAVE"

**✅ Android config added?** [ ]

---

### [ ] STEP 8: Update strings.xml

**Open this file:**
`android/app/src/main/res/values/strings.xml`

**Find this line:**
```xml
<string name="default_web_client_id">YOUR_WEB_CLIENT_ID_HERE</string>
```

**Replace `YOUR_WEB_CLIENT_ID_HERE` with your actual Client ID from Step 6**

**Example:**
```xml
<string name="default_web_client_id">123456789-abcdefghijklmnop.apps.googleusercontent.com</string>
```

**✅ File saved?** [ ]

---

### [ ] STEP 9: Wait 5-10 Minutes

**⚠️ IMPORTANT:** Google needs time to process your SHA-1 fingerprint.

**✅ Waited 5-10 minutes?** [ ]

---

### [ ] STEP 10: Rebuild and Test

```powershell
flutter clean
flutter pub get
flutter run
```

**✅ App rebuilt?** [ ]

**✅ Tested Google Sign-In?** [ ]

---

## 🎉 If It Works:
You should see the Google account picker when you tap "Sign in with Google"

## ❌ If Still Error 10:
1. Double-check Client ID in strings.xml matches exactly
2. Verify SHA-1 is correct (no extra spaces)
3. Make sure you waited 5-10 minutes
4. Check Google Cloud Console → Your OAuth Client → Android section shows package name and SHA-1

---

## 📝 Quick Reference:

- **Package name:** `com.example.penoft_machine_test`
- **File to edit:** `android/app/src/main/res/values/strings.xml`
- **What to replace:** `YOUR_WEB_CLIENT_ID_HERE`
- **Wait time:** 5-10 minutes after adding SHA-1


