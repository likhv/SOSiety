//
//  SOSietyApp.swift
//  Shared
//
//  Created by Vladislav Likh on 07/02/22.
//

import SwiftUI

@main
struct SOSietyApp: App {
    var body: some Scene {
        WindowGroup {
            LoopedWaveAnimationView()
//            MainScreenView()
                .preferredColorScheme(.light)
//            SettingsView()
                .environmentObject(ViewModel())
                .environmentObject(InformationScreenViewModel())
                .environmentObject(ContactsViewModel())
            
        }
    }
}
