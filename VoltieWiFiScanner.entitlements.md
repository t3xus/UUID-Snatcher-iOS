# Explanation of Keys

- **com.apple.developer.networking.HotspotConfiguration**  
  Enables the app to scan for and configure Wi-Fi networks.

- **com.apple.developer.location-services**  
  Required for location-based Wi-Fi scanning.

- **com.apple.background-mode**  
  Allows the app to perform fetch operations in the background.

- **com.apple.security.network.client**  
  Grants permission for network access.

- **keychain-access-groups**  
  Allows the app to securely store Wi-Fi credentials in the Keychain.

---

## Steps to Add This File to Your Project

1. Save this file as `VoltieWiFiScanner.entitlements`
2. Add the file to your Xcode project:
   - Go to **Signing & Capabilities**.
   - Select the **+ Capability** button.
   - Enable **Hotspot Configuration** and **Location Services**.
3. Ensure this file is selected under **Code Signing Entitlements** in your project's build settings.
