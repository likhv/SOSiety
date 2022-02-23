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
        InformationScreen(icon: "on1-2", heading: "We’ll inform chosen contacts about the fact of arrest", description: "When SOS mode start, we’ll send a message with detailed instruction about the way they can help you and your current location (if you allowed it). Also you can inform local human rights organizations"),
        InformationScreen(icon: "on2", heading: "You can start a SOS mode manually, just swipe switcher right", description: "Notifications will be sent in 30 seconds, so in case of occasional start you’ll have time to stop it. We’ll provide you a current status of notifications: who’s already read notification, etc. You can also choose a frequency of location sharing"),
//        InformationScreen(icon: "onboardingImage", heading: "Or use check in mode", description: "We will frequently ask you to check your status with FaceID or password. If you don't do that, we'll start emegency mode automatically."),
//        InformationScreen(icon: "onboardingImage", heading: "Start with adding emergency contacts", description: "Add contacts from the phonebook or choose human rights organisation to notify them in case of arrest.")
    ]
}
