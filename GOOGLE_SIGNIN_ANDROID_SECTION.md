# 🔍 How to Add Android Configuration to Web Client

## Problem: Android Section Not Visible

If you don't see an "Android" section when editing your Web client, try these steps:

## Method 1: Scroll Down Further

1. **Edit your Web client** (`158505151760-603n6v39617s41909288pq728os3ln6q`)
2. **Scroll ALL the way down** - the Android section is usually at the very bottom
3. Look for a section titled **"Android apps"** or **"Android"**
4. If you see it, click **"ADD PACKAGE NAME AND FINGERPRINT"**

## Method 2: Check if Section is Collapsed

1. Look for any **expandable sections** or **arrows (▼/▶)**
2. The Android section might be collapsed by default
3. Click to expand it

## Method 3: Alternative - Add via REST API or Create New Client

If the Android section truly doesn't exist in the Web client UI, you have two options:

### Option A: Use Google Cloud Console API (Advanced)

You can add Android configuration via the API, but this is complex.

### Option B: Create a Separate Android Client (Simpler)

If Google Cloud Console doesn't allow adding Android config to Web clients in your region/version:

1. **Create a NEW Android OAuth client:**
   - Go to Credentials → Create Credentials → OAuth client ID
   - Application type: **Android**
   - Name: "Android client for penoft_machine_test"
   - Package name: `com.example.penoft_machine_test`
   - SHA-1: (your SHA-1 fingerprint)
   - Click Create

2. **Update your code to use BOTH:**
   - Keep the Web client ID in `strings.xml`
   - The Android client will be automatically used by Google Sign-In SDK

Actually, wait - for Google Sign-In on Android, you should ONLY use the Web client ID. The Android client is not needed if you're using the Web client ID approach.

## Method 4: Check Google Cloud Console Version

Some versions of Google Cloud Console might have the Android section in a different location:

1. Look for tabs or sections like:
   - "Platforms"
   - "Restrictions"
   - "Additional settings"
   - "Advanced"

2. The Android configuration might be under one of these sections

## Method 5: Use Firebase Console (If Using Firebase)

If you're using Firebase:
1. Go to Firebase Console
2. Select your project
3. Go to Authentication → Sign-in method → Google
4. Add Android package name and SHA-1 there

## ⚠️ Important Note

For Google Sign-In on Android with Flutter:
- You MUST use a **Web application** type OAuth client ID
- The Android package name + SHA-1 should be added to that Web client
- If the UI doesn't show Android section, it might be a Google Cloud Console UI issue

## 🔧 Quick Test

Try this:
1. Create a completely NEW Web client
2. See if the Android section appears in the new client
3. If it does, you can migrate to the new client ID
4. If it doesn't, it might be a regional/account limitation

## 📞 Next Steps

If none of these work, you might need to:
1. Contact Google Cloud Support
2. Check if your Google Cloud account has any restrictions
3. Try using a different browser or incognito mode
4. Check Google Cloud Console documentation for your specific region

