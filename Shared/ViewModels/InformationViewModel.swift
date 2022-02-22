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
        InformationScreen(icon: "onboardingImage", heading: "We'll inform selected contacts in case of arrest", description: "In case of arrest, we will inform your contacts about the fact of arrest, share location and provide instructions about next steps"),
        InformationScreen(icon: "onboardingImage", heading: "Run emergency manually", description: "Push emergency button manually if you're arrested. Contacts will be informed immediately. Also you can share your location."),
        InformationScreen(icon: "onboardingImage", heading: "Or use check in mode", description: "We will frequently ask you to check your status with FaceID or password. If you don't do that, we'll start emegency mode automatically."),
        InformationScreen(icon: "onboardingImage", heading: "Start with adding emergency contacts", description: "Add contacts from the phonebook or choose human rights organisation to notify them in case of arrest.")
    ]
}
