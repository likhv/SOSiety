//
//  InformationViewModel.swift
//  SOSiety
//
//  Created by Natalia Kuznetsova on 18/02/22.
//

import Foundation
import SwiftUI



class InformationScreenViewModel: ObservableObject {
    @Published var informationScreens: [InformationScreen] = [
        InformationScreen(icon: "on1-2", heading: "In case of arrest, we’ll notify selected contacts", description: "When SOS mode is on, we’ll share your location with them (if you allowed us) and we’ll also send them clear step-by-step instructions about how to help you. Local human rights organisations will be informed of the fact of your arrest, as well"),
        InformationScreen(icon: "on2", heading: "Turn on SOS mode by simply swiping right", description: "Notification sending will be delayed by 30 seconds, therefore a notification will not be sent if the SOS button has been swiped accidentally. You’ll be informed of the notification delivery status: we’ll let you know when the notification is sent, delivered and read"),
//        InformationScreen(icon: "onboardingImage", heading: "Or use check in mode", description: "We will frequently ask you to check your status with FaceID or password. If you don't do that, we'll start emegency mode automatically."),
//        InformationScreen(icon: "onboardingImage", heading: "Start with adding emergency contacts", description: "Add contacts from the phonebook or choose human rights organisation to notify them in case of arrest.")
    ]
}
