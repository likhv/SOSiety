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
                ForEach(informationScreenViewModel.informationScreens, id:\.id) {informationScreen in
                    VStack (alignment: .leading, spacing: 20) {
                        Image(informationScreen.icon)
                            .resizable()
                            .scaledToFit()
                            .padding(.horizontal, 20)
                            .padding(.bottom, 50)
                            
                        Text(informationScreen.heading).font(.largeTitle).fontWeight(.bold)
                            .padding(.horizontal, 30)
                           
                        Text(informationScreen.description).font(.title3)
                            .padding(.horizontal, 30)
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

struct InformationView_Previews: PreviewProvider {
    static var previews: some View {
        MainScreenView(isInfoPresenting: true)
            .environmentObject(ViewModel())
            .environmentObject(InformationScreenViewModel())
    }
}
