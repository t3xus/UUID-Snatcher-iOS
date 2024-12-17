import UIKit
import NetworkExtension
import CoreLocation
import MessageUI

class ViewController: UIViewController, MFMailComposeViewControllerDelegate, CLLocationManagerDelegate {

    var locationManager = CLLocationManager()
    var previouslySentAPs: [String] = []
    var availableNetworks: [NEHotspotNetwork] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        requestLocationAccess()
        loadPreviouslySentAPs()
    }

    func requestLocationAccess() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
    }

    func loadPreviouslySentAPs() {
        if let saved = UserDefaults.standard.array(forKey: "previouslySentAPs") as? [String] {
            previouslySentAPs = saved
        }
    }

    func scanAndConnectToJuiceNetworks() {
        NEHotspotHelper.register(options: nil, queue: DispatchQueue.main) { cmd in
            if cmd.commandType == .filterScanList {
                self.availableNetworks = cmd.networkList?.filter { $0.ssid.contains("Juice") && !self.previouslySentAPs.contains($0.ssid) } ?? []
                self.showNetworkSelection()
            }
        }
    }

    func showNetworkSelection() {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Available Networks", message: "Select a Juice AP to connect", preferredStyle: .actionSheet)
            for network in self.availableNetworks {
                alert.addAction(UIAlertAction(title: network.ssid, style: .default, handler: { _ in
                    self.connectToNetwork(ssid: network.ssid)
                }))
            }
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            self.present(alert, animated: true)
        }
    }

    func connectToNetwork(ssid: String) {
        let config = NEHotspotConfiguration(ssid: ssid)
        NEHotspotConfigurationManager.shared.apply(config) { error in
            if error == nil {
                self.fetchUUID(ssid: ssid)
            }
        }
    }

    func fetchUUID(ssid: String) {
        guard let url = URL(string: "http://10.10.10.1/command/get+system.uuid") else { return }
        let task = URLSession.shared.dataTask(with: url) { data, _, _ in
            if let data = data, let uuid = String(data: data, encoding: .utf8) {
                self.sendEmail(uuid: uuid, ssid: ssid)
            }
        }
        task.resume()
    }

    func sendEmail(uuid: String, ssid: String) {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(["support@voltiegroup.com"])
            mail.setSubject("Device UUID")
            mail.setMessageBody("SSID: \(ssid)\nUUID: \(uuid)", isHTML: false)
            self.present(mail, animated: true) {
                self.saveSSID(ssid: ssid)
            }
        }
    }

    func saveSSID(ssid: String) {
        previouslySentAPs.append(ssid)
        UserDefaults.standard.set(previouslySentAPs, forKey: "previouslySentAPs")
    }

    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
}
