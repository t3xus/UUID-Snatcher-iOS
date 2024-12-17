
![Static Badge](https://img.shields.io/badge/Author-Jgooch-1F4D37)
![Static Badge](https://img.shields.io/badge/Distribution-npm-orange)
![Target](https://img.shields.io/badge/Target-Apple%20iOS%2011%20-357EC7)
## **JuiceNet-Voltie**
## **The VoltiE UUID Snatcher**

### **Overview**
VoltiE UUID Snatcher is an iOS application designed to:
- Scan for Wi-Fi Access Points (APs) with names containing **"Juice"**.
- Allow users to select and connect to the desired AP.
- Fetch a UUID by accessing `http://10.10.10.1/command/get+system.uuid`.
- Email the UUID to `support@voltiegroup.com`.
- Persist previously processed APs to avoid redundant connections.

---

### **Features**
- **Wi-Fi Scanning**: Lists all APs with names containing "Juice."
- **AP Selection**: Users can pick specific APs to connect to.
- **UUID Fetching**: Fetches the UUID from the AP’s HTTP interface.
- **Email Integration**: Automatically sends the UUID to a support email.
- **Persistence**: Skips APs previously processed by saving them locally.

---

### **Technical Details**

| Feature                    | Details                                          |
|----------------------------|-------------------------------------------------|
| **Platform**               | iOS                                             |
| **Frameworks**             | `NetworkExtension`, `CoreLocation`, `MessageUI` |
| **Persistence**            | `UserDefaults`                                  |
| **Network API**            | `NEHotspotConfiguration`, `URLSession`          |
| **Languages**              | Swift                                           |
| **Email**                  | Sent via `MFMailComposeViewController`          |

---

### **How It Works**

1. **Wi-Fi Scanning**: 
   - The app scans for APs containing "Juice" in their SSID.
   - Skips networks previously processed.

2. **User Interaction**:
   - Displays a list of matching networks.
   - Allows the user to select an AP to connect to.

3. **Connection & UUID Fetch**:
   - The app connects to the selected AP using **NEHotspotConfiguration**.
   - Fetches the UUID from the AP’s endpoint `http://10.10.10.1/command/get+system.uuid`.

4. **Email Automation**:
   - Emails the UUID to `support@voltiegroup.com`.

5. **Persistence**:
   - The app saves previously processed APs in `UserDefaults` to avoid reprocessing.

---

### **Installation**

1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/VoltiE-UUID-Snatcher.git
   ```

2. Open the project in Xcode:
   ```bash
   cd VoltiE-UUID-Snatcher
   open VoltiEUUIDSnatcher.xcodeproj
   ```

3. Configure your Apple Developer account and entitlements.

4. Build and run the app on a physical iOS device.

---

### **Usage**

1. Launch the app on your iPhone.
2. Allow location permissions when prompted.
3. Select a Wi-Fi network starting with "Juice" from the list.
4. The app will:
   - Connect to the selected AP.
   - Fetch the UUID.
   - Send an email to `support@voltiegroup.com` with the UUID.
5. Previously processed APs will not appear again.



### **Contact**
For support, contact us at:
- **Email**: support@voltiegroup.com
- **Website**: [https://support.voltie.us](https://support.voltie.us)
