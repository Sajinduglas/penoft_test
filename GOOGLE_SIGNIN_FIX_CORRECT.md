# ✅ Correct Google Sign-In Setup for Android

## Important: Use ONE Web Client ID with Android Configuration

For Google Sign-In on Android, you need:
- ✅ **ONE Web application type OAuth client ID** (you already have this)
- ✅ **Add Android package name + SHA-1 to that SAME Web client** (this is what you need to do)

**DO NOT create a separate Android client!** Add Android config to your existing Web client.

## Step-by-Step Fix

### Step 1: Get Your SHA-1 Fingerprint

Run this command:
```powershell
keytool -list -v -keystore "$env:USERPROFILE\.android\debug.keystore" -alias androiddebugkey -storepass android -keypass android
```

Look for:
```
SHA1: XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX
```

**COPY THE SHA1 VALUE** (the part after "SHA1: ")

### Step 2: Edit Your EXISTING Web Client

1. Go to: https://console.cloud.google.com/
2. Select your project
3. Go to **APIs & Services** → **Credentials**
4. Find your **Web application** client: `158505151760-603n6v39617s41909288pq728os3ln6q.apps.googleusercontent.com`
5. **Click on it to EDIT** (don't create a new one!)

### Step 3: Add Android Configuration to the Web Client

1. Scroll down in the edit page
2. Find the **"Android"** section (it might be collapsed)
3. Click **"ADD PACKAGE NAME AND FINGERPRINT"** button
4. Enter:
   - **Package name**: `com.example.penoft_machine_test`
   - **SHA-1 certificate fingerprint**: (paste the SHA-1 from Step 1)
5. Click **"SAVE"** at the bottom of the page

### Step 4: Verify strings.xml

Your `android/app/src/main/res/values/strings.xml` should have:
```xml
<string name="default_web_client_id">158505151760-603n6v39617s41909288pq728os3ln6q.apps.googleusercontent.com</string>
```

✅ This is already correct!

### Step 5: Rebuild and Test

```powershell
flutter clean
flutter pub get
flutter run
```

## ⚠️ Common Mistakes

❌ **DON'T** create a separate Android OAuth client
✅ **DO** add Android config to your existing Web client

❌ **DON'T** use the Android client ID in your code
✅ **DO** use the Web client ID (which you're already doing)

## 🔍 Visual Guide

When editing your Web client, you should see:
- **Application type**: Web application
- **Name**: (your web client name)
- **Authorized JavaScript origins**: (your web URLs)
- **Authorized redirect URIs**: (your web redirects)
- **Android** section: ← **ADD PACKAGE NAME AND SHA-1 HERE**

## 📝 Summary

1. Use the **Web client ID** in your code ✅ (already done)
2. Add **Android package name + SHA-1** to that **same Web client** in Google Cloud Console
3. Wait 5-10 minutes for changes to propagate
4. Rebuild and test

The key is: **One Web client, with Android configuration added to it!**

