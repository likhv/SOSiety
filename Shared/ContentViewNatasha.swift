//
//  ContentViewNatasha.swift
//  SOSiety
//
//  Created by Vladislav Likh on 14/02/22.
//

import SwiftUI

struct ContentViewNatasha: View {
    @State private var offset = CGSize.zero

    var body: some View {
        NavigationView {
            VStack {
                Text("Everything is ready")
                    .font(.largeTitle).fontWeight(.bold)
                ZStack {
                    Text("Swipe right to start").fontWeight(.bold)
                    Capsule()
                        .frame(height: 90)
                        .overlay(Text("Swipe right to start").foregroundColor(.white).fontWeight(.bold))
                        .overlay(Circle()
                                    .foregroundColor(.white)
                                    .overlay(Text("SOS").font(.title).fontWeight(.bold))
                                    .padding(5.0)
                                    .offset(x: offset.width, y: 0)
                                    .position(x: 45, y: 45)
                                    .gesture(
                                        DragGesture()
                                            .onChanged {gesture in offset = gesture.translation}
                                            .onEnded {
                                                _ in if abs(offset.width) > 100 {

                                                } else {
                                                    offset = .zero
                                                }
                                            }))
                }
            }
            .navigationTitle("#SOSiety")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(leading: NavigationLink(destination:
                                                            InformationView(), label: {
                Image(systemName: "info")
            }), trailing: NavigationLink(destination: SettingsView(), label: {
                Image(systemName: "gearshape")
            }))
            .padding()
            .accentColor(.black)
        }
    }
}
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
            .navigationBarTitleDisplayMode(.inline)
        }
        .padding()
    }
}
struct InformationView: View {
    var body: some View {
        VStack {
            Image(systemName: "checklist").resizable().scaledToFit().padding()
            Text("Start with adding emergency contacts")
                .font(.largeTitle).fontWeight(.bold)
            Text("Add contacts from the phonebook or choose human rights organisation to notify them in case of arrest.").font(.title3)
                .padding()
        }
        .navigationTitle("How the app works")
        .navigationBarTitleDisplayMode(.inline)
    }
}
struct ContentViewNatasha_Previews: PreviewProvider {
    static var previews: some View {
        ContentViewNatasha()
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}

struct InformationView_Previews: PreviewProvider {
    static var previews: some View {
        InformationView()
    }
}
