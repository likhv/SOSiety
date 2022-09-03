//
//  SOSmodel.swift
//  SOSiety
//
//  Created by Vladislav Likh on 08/02/22.
//

import Foundation
import Alamofire
import CoreLocation
import SwiftUI





class SOSViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {

    @Published var isSOS: Bool = false
    @Published var geoString: String = ""
    @Published var isCheckIn: Bool = false
    @Published var notificationCountdown: Int = 30
    @Published var history: [String] = []
    @Published var statusConsole: [String] = []
    @Published var userName: String = ""
    @Published var firstScreenPresented: Bool = true
    @Published var enAdviceList: [Advice] = [
        Advice(text: "Stay calm and confident. Don’t panic, don’t resist and don’t be provoked"),
        Advice(text: "Avoid answering any questions and signing anything"),
        Advice(text: "Find out the official reason of your detention"),
        Advice(text: "Collect the details, including names and titles of policemen"),
        Advice(text: "Ask any witnesses for their contact details"),
//        Advice(text: "Ask those who witnessed your arrest to share their contacts")
    ]
    @Published var ruAdviceList: [Advice] = [
        Advice(text: "Сохраняй спокойствие и уверенность. Пожалуйста, не паникуй и не оказывай сопротивление."),
        Advice(text: "Не поддавайся на провокации. Мы настоятельно рекомендуем тебе не отвечать ни на какие вопросы и ничего не подписывать, особенно чистые листы бумаги."),
        Advice(text: "По возможности выясни официальную причину задержания. Постарайся запомнить и/или снять на фото/видео детали, касающиеся задержания, включая фамилии и должности полицейских, и их отличительные черты."),
        Advice(text: "Рекомендуем взять контактные данные у всех свидетелей задержания."),
//        Advice(text: "Ask those who witnessed your arrest to share their contacts")
    ]
    @Published var frAdviceList: [Advice] = [
        Advice(text: "Il est essentiel de rester calme et confiant, de ne pas paniquer et d’opposer aucune résistance."),
        Advice(text: "Ne répond pas aux provocations. Nous te recommandons très fortement d’éviter de répondre aux questions et de ne pas signer quoi que ce soit, surtout des feuilles de papier vierges."),
        Advice(text: "Si possible, essaie de savoir le motif officiel de ta détention. Essaie également de mémoriser et/ou bien de photographier / d’enregistrer sur vidéo les détails de la détention, y compris les noms et les titres des policiers et leurs caractéristiques distinctives."),
        Advice(text: "Il est conseillé de relever les coordonnées des témoins."),
//        Advice(text: "Ask those who witnessed your arrest to share their contacts")
    ]
    @Published var timeRemaining: Int = 100
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
        
//        statusConsole.append(TimerView())
        sendSMS(to: contacts)
    }
    
    func stopSOS() {
        isSOS = false
        notificationCountdown = 30
        statusConsole = []
    }
    
    func sendSMS(to contacts: [ContactInfo]) {
        print("Sms sending")
        self.statusConsole.append("Notification sending")

          let url = ""
        
        for contact in contacts {
            let parameters = ["From": "+19036485850", "To": contact.phoneNumber?.stringValue, "Body": "#SOSiety\n\(userName) reported the fact of detention.\n\nCurrent location: https://www.google.com/maps/place/\(locationManager?.location?.coordinate.latitude ?? 0),\(locationManager?.location?.coordinate.longitude ?? 0)\n\nWhat to do next: https://readymag.com/3449727" ]

            AF.request(url, method: .post, parameters: parameters)
                  
              .authenticate(username: "", password: "")
              .responseJSON { response in
                  self.statusConsole[0] = "Notification sent"
            }
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
    
}
