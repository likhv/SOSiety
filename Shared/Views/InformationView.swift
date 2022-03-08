//
//  InformationView.swift
//  SOSiety
//
//  Created by Vladislav Likh on 14/02/22.
//

import SwiftUI

struct InformationView: View {
    @EnvironmentObject var informationScreenViewModel: InformationScreenViewModel
    @Binding var isInfoPresenting: Bool
    var body: some View {
        ZStack {
            Color.sosietyPaper.ignoresSafeArea()
            TabView {
                if Locale.preferredLanguages[0].prefix(2) == "ru" {
                    ForEach(informationScreenViewModel.ruInformationScreens, id:\.id) {informationScreen in
                        InformationItem(informationScreen: informationScreen)
                    }
                } else if Locale.preferredLanguages[0].prefix(2) == "fr" {
                    ForEach(informationScreenViewModel.frInformationScreens, id:\.id) {informationScreen in
                        InformationItem(informationScreen: informationScreen)
                    }
                } else {
                    ForEach(informationScreenViewModel.engInformationScreens, id:\.id) {informationScreen in
                        InformationItem(informationScreen: informationScreen)
                    }
                }
                
            }
            Button {isInfoPresenting = false} label: {
                Image(systemName: "multiply")
                    .foregroundColor(.black)
                    .font(.system(size: 20))
                    .position(x: 32, y: 22)
            }
        }
        .tabViewStyle(.page)
        .indexViewStyle(.page(backgroundDisplayMode: .always))
        .navigationTitle("How the app works")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct InformationItem: View {
    var informationScreen: InformationScreen
    var body: some View {
        ZStack {
            VStack {
                Image(informationScreen.icon)
                    .resizable()
                    .scaledToFit()
                    .padding(.horizontal, 40)
                    .padding(.top, 120)
                Spacer()
            }
            VStack (alignment: .leading, spacing: 20) {
                Spacer()
                Text(informationScreen.heading)
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.horizontal, 30)
                Text(informationScreen.description)
                    .font(.system(size: 18, weight: .medium))
                    .padding(.horizontal, 30)
            }
            .padding(.bottom, 60)
        }
    }
}

struct InformationView_Previews: PreviewProvider {
    static var previews: some View {
        MainScreenView(isInfoPresenting: true)
            .previewDevice("iPhone 12")
            .environmentObject(SOSViewModel())
            .environmentObject(InformationScreenViewModel())
    }
}
