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
                        Spacer()
                        
                        Image(informationScreen.icon)
                            .resizable()
                            .scaledToFit()
                            .padding(.horizontal, 40)
//                            .padding(.bottom, 20)
                            
                        Spacer()
                        
                        Text(informationScreen.heading)
                            .font(.title)
                            .fontWeight(.bold)
                            .padding(.horizontal, 30)
                           
                        Text(informationScreen.description)
                            .font(.system(size: 18, weight: .medium))
                            .padding(.horizontal, 30)
                        
                        Spacer()
                    }
//                    .padding(.top, 80)
                    
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
            .previewDevice("iPhone 12")
            .environmentObject(ViewModel())
            .environmentObject(InformationScreenViewModel())
    }
}
