//
//  ContentViewNatasha.swift
//  SOSiety
//
//  Created by Vladislav Likh on 14/02/22.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        VStack {
            HStack {
                Text ("Emergency contact").font(.title3).bold()
                Spacer()
                Button ("+") {
                    
                }
            }
            List {
            }
            .navigationTitle("Settings")
        }
        .padding()
    }
}


struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}


