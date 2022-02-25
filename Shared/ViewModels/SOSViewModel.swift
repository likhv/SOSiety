//
//  SOSmodel.swift
//  SOSiety
//
//  Created by Vladislav Likh on 08/02/22.
//

import Foundation





class SOSViewModel: ObservableObject {
    
    @Published var isSOS: Bool = false
    @Published var isCheckIn: Bool = false
    @Published var notificationCountdown: Int = 30
    @Published var history: [String] = []
    @Published var statusConsole: [String] = []
    @Published var userName: String = ""
    @Published var isFirstStart: Bool = true
    @Published var adviceList: [Advice] = [
        Advice(text: "Stay calm and confident, don't resist or panic"),
        Advice(text: "Inform trusted contacts about your arrest, location and ask them to find a lawyer for you in case you don't have one"),
        Advice(text: "Don't be provoked, respond to questions or sign anything suspicious, especially plain papers"),
        Advice(text: "Try to fix facts related to your arrest - names and titles of policemen, their peculiarities, declared reason for arrest"),
        Advice(text: "Ask those who witnessed your arrest to share their contacts")
    ]
        
    func startCheckIn() {
        isCheckIn = true
    }
    
    func stopCheckIn() {
        isCheckIn = false
    }
    
    func startSOS() {
        isSOS = true
        statusConsole.append("Sending in 0:15")
    }
    
    func stopSOS() {
        isSOS = false
        notificationCountdown = 30
        statusConsole = []
    }
    
    func sendSMS() {
        print("Sms sending")
        history.append("Notifications sent")
    }
    
}
