//
//  SOSmodel.swift
//  SOSiety
//
//  Created by Vladislav Likh on 08/02/22.
//

import Foundation


class ViewModel: ObservableObject {
    
    @Published var isSOS: Bool = false
    @Published var isCheckIn: Bool = false
    @Published var notificationCountdown: Int = 30
    @Published var history: [String] = []
        
    func startCheckIn() {
        isCheckIn = true
    }
    
    func stopCheckIn() {
        isCheckIn = false
    }
    
    func startSOS() {
        isSOS = true
    }
    
    func stopSOS() {
        isSOS = false
        notificationCountdown = 30
    }
    
    func sendSMS() {
        print("Sms sending")
        history.append("Notifications sent")
    }
    
}
