//
//  SOSmodel.swift
//  SOSiety
//
//  Created by Vladislav Likh on 08/02/22.
//

import Foundation
import Alamofire
import CoreLocation





class SOSViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {

    @Published var isSOS: Bool = false
    @Published var geoString: String = ""
    @Published var isCheckIn: Bool = false
    @Published var notificationCountdown: Int = 30
    @Published var history: [String] = []
    @Published var statusConsole: [String] = []
    @Published var userName: String = ""
    @Published var firstScreenPresented: Bool = true
    @Published var adviceList: [Advice] = [
        Advice(text: "Stay calm and confident, don't resist or panic"),
        Advice(text: "Inform trusted contacts about your arrest, location and ask them to find a lawyer for you in case you don't have one"),
        Advice(text: "Don't be provoked, respond to questions or sign anything suspicious, especially plain papers"),
        Advice(text: "Try to fix facts related to your arrest - names and titles of policemen, their peculiarities, declared reason for arrest"),
        Advice(text: "Ask those who witnessed your arrest to share their contacts")
    ]
    
    var locationManager: CLLocationManager?
    
    func checkIfLocationServicesIsEnabled() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager = CLLocationManager()
            locationManager?.desiredAccuracy = kCLLocationAccuracyBest
            locationManager!.delegate = self
        } else {
            
        }
    }
    
    func checkLocationAuthorization() {
        guard let locationManager = locationManager else { return }
        
        switch locationManager.authorizationStatus {
            
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            print("")
        case .denied:
            print("")
        case .authorizedAlways, .authorizedWhenInUse:
            break
        @unknown default:
            break
        }
    }
        
    func startCheckIn() {
        isCheckIn = true
    }
    
    func stopCheckIn() {
        isCheckIn = false
    }
    
    func startSOS(to contacts: [ContactInfo]) {
        isSOS = true
        statusConsole.append("Sending in 0:15")
        sendSMS(to: contacts)
    }
    
    func stopSOS() {
        isSOS = false
        notificationCountdown = 30
        statusConsole = []
    }
    
    func sendSMS(to contacts: [ContactInfo]) {
        print("Sms sending")
        history.append("Notifications sent")
//        if let accountSID = ProcessInfo.processInfo.environment["ACe684f07971128ca114d257bac6981ea0"],
//           let authToken = ProcessInfo.processInfo.environment["4588dd65f127f5586583680a5feac55d"] {

          let url = "https://api.twilio.com/2010-04-01/Accounts/ACe684f07971128ca114d257bac6981ea0/Messages"
        
        for contact in contacts {
            let parameters = ["From": "+19036485850", "To": contact.phoneNumber?.stringValue, "Body": "“#SOSiety\n\n\(userName) reported the fact of arrest.\n\nHis current location: https://www.google.com/maps/place/\(locationManager?.location?.coordinate.latitude ?? 0),\(locationManager?.location?.coordinate.longitude ?? 0)" ]
            AF.request(url, method: .post, parameters: parameters)
                  
              .authenticate(username: "ACe684f07971128ca114d257bac6981ea0", password: "4588dd65f127f5586583680a5feac55d")
              .responseJSON { response in
                debugPrint(response)
            }
        }
        
          
//        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
    
}
