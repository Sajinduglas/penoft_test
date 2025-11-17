# 🚨 URGENT: YOU MUST DO THIS TO FIX ERROR CODE 10

## ❌ CURRENT PROBLEM:
Your `strings.xml` file STILL has: `YOUR_WEB_CLIENT_ID_HERE`

This is why you keep getting Error Code 10!

---

## ✅ SOLUTION: Choose ONE of these methods

### METHOD 1: Update strings.xml (Recommended)

**Step 1:** Get OAuth Client ID from Google Cloud Console (see instructions below)

**Step 2:** Open `android/app/src/main/res/values/strings.xml`

**Step 3:** Replace this line:
```xml
<string name="default_web_client_id">YOUR_WEB_CLIENT_ID_HERE</string>
```

**With your actual Client ID:**
```xml
<string name="default_web_client_id">123456789-abcdefghijklmnop.apps.googleusercontent.com</string>
```

**Step 4:** Save and rebuild

---

### METHOD 2: Pass Client ID in Code (Alternative)

I've updated your code to accept Client ID directly. But you STILL need to get it from Google Cloud Console first!

**Step 1:** Get OAuth Client ID (see instructions below)

**Step 2:** Update the code with your Client ID (I'll show you how)

---

## 📋 HOW TO GET OAUTH CLIENT ID (YOU MUST DO THIS FIRST!)

### Quick Steps:

1. **Go to:** https://console.cloud.google.com/

2. **Create/Select Project:**
   - Click project dropdown → "NEW PROJECT"
   - Name it → Click "CREATE"

3. **Enable API:**
   - "APIs & Services" → "Library"
   - Search "Google Sign-In API" → Click "ENABLE"

4. **OAuth Consent Screen:**
   - "APIs & Services" → "OAuth consent screen"
   - Choose "External"
   - Fill: App name, Your email, Your email
   - Click "SAVE AND CONTINUE" (3 times)

5. **Create OAuth Client ID:**
   - "APIs & Services" → "Credentials"
   - "+ CREATE CREDENTIALS" → "OAuth client ID"
   - Type: **"Web application"** ⚠️ MUST BE WEB!
   - Name: "My App Web Client"
   - Click "CREATE"
   - **COPY THE CLIENT ID** (looks like: `123456789-xxx.apps.googleusercontent.com`)

6. **Get SHA-1 and Add to OAuth Client:**
   - Run: `cd android && .\gradlew signingReport`
   - Copy SHA-1 value
   - Go back to Credentials → Click your OAuth Client ID
   - Scroll to "Android" → "ADD PACKAGE NAME AND FINGERPRINT"
   - Package: `com.example.penoft_machine_test`
   - SHA-1: Paste your SHA-1
   - Click "SAVE"

---

## ⚠️ YOU CANNOT SKIP THESE STEPS!

- ❌ You MUST create OAuth Client ID in Google Cloud Console
- ❌ You MUST add SHA-1 fingerprint
- ❌ You MUST replace `YOUR_WEB_CLIENT_ID_HERE` with real Client ID
- ❌ You MUST wait 5-10 minutes after adding SHA-1

**There is NO way around this. Google Sign-In requires proper OAuth configuration.**


