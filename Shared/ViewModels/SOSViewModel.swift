//
//  SOSmodel.swift
//  SOSiety
//
//  Created by Vladislav Likh on 08/02/22.
//

import Foundation


struct Advice: Identifiable {
    var id = UUID()
    var title = "Some title here"
    var text = "If you aren’t sure about documents officers ask you to sign, try not to do that. It is also important with empty blanks"
}


class ViewModel: ObservableObject {
    
    @Published var isSOS: Bool = false
    @Published var isCheckIn: Bool = false
    @Published var notificationCountdown: Int = 30
    @Published var history: [String] = []
    @Published var statusConsole: [String] = []
    @Published var adviceList: [Advice] = [
        Advice(),
        Advice(),
        Advice(),
        Advice(),
        Advice()
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
