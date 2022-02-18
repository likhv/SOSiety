//
//  ContentViewNatasha.swift
//  SOSiety
//
//  Created by Vladislav Likh on 14/02/22.
//

import SwiftUI

struct SettingsView: View {
    @State private var isPresented = false
    var body: some View {
        VStack {
            HStack {
                Text ("Emergency contact").font(.title3).bold()
                Spacer()
                Button ("+") {
                    isPresented.toggle()
                }
                .fullScreenCover(isPresented: $isPresented, content: ContactsListView.init)
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


