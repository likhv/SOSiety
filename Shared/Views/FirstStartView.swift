//
//  FirstStartView.swift
//  SOSiety
//
//  Created by Vlad Likh on 23.02.2022.
//

import SwiftUI

struct FirstStartView: View {
    @EnvironmentObject var informationScreenViewModel: InformationScreenViewModel
    @EnvironmentObject var contactsViewModel: ContactsViewModel
    var body: some View {
        ZStack {
            Color.sosietyPaper.ignoresSafeArea()
            TabView {
                FirstStartEnterNameView()
                FirstStartAddContactView()
                ForEach(informationScreenViewModel.informationScreens, id:\.id) {informationScreen in
                    InformationItem(informationScreen: informationScreen)
                }
                
            }
            if contactsViewModel.allContacts.count != 0 {
                VStack {
                    Spacer()
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .frame(height: 60)
                        .overlay(
                            Text("Save settings")
                                .foregroundColor(.white)
                        )
                        .padding(25)
                        .padding(.bottom, 40)
                }
            }
        }
        .tabViewStyle(.page)
        .indexViewStyle(.page(backgroundDisplayMode: .always))
        .navigationTitle("How the app works")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct FirstStartEnterNameView: View {
    @EnvironmentObject var SOSViewModel: SOSViewModel
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {

            Text("Let's start with introductions.\nWhat’s your name?")
                .foregroundColor(.black)
                .font(.title)
                .fontWeight(.bold)
                .padding(.horizontal, 2)
                .padding(.bottom, 30)
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .stroke(.black, lineWidth: 2)
                .frame(height: 55)
//                .foregroundColor(Color(.systemGray5))
                .foregroundColor(.black)
                .overlay(
                    HStack {
                        TextField(
                                "Your name",
                                text: $SOSViewModel.userName
                            )
                            .disableAutocorrection(true)
                            .textFieldStyle(.plain)
                            .padding()
                        if SOSViewModel.userName != "" {
                            Button {} label: {
                                Image(systemName: "arrow.right.circle.fill")
                                    .font(.system(size: 24, weight: .medium))
                                    .foregroundColor(.black)
                                    .padding(15)
                            }
                        }
                    }
                    )
            Spacer()
        }
        .padding(.top, 100)
        .padding(.horizontal, 30)
    }
}

struct FirstStartAddContactView: View {
    @EnvironmentObject var contactsViewModel: ContactsViewModel
    @State private var isPresented = false
    var body: some View {
        VStack(alignment: .leading, spacing: 50) {

            Text("Choose contacts\nyou want to inform\nin case of arrest")
                .foregroundColor(.black)
                .font(.title)
                .fontWeight(.bold)
                .padding(.horizontal, 2)

            Button { isPresented = true } label : {
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .frame(height: 55)
                    .foregroundColor(.black)
                    .overlay(
                        HStack {
                            Image(systemName: "person.badge.plus")
                                .foregroundColor(.white)
                                .font(.system(size: 18, weight: .medium))
                            Text("Choose contacts")
                                .foregroundColor(.white)
                                .font(.system(size: 16, weight: .medium))
                        }
                    )
                    
            }
            Spacer()
        }
        .padding(.top, 100)
        .padding(.horizontal, 30)
        .fullScreenCover(isPresented: $isPresented) {
            ContactsListView(isPresented: $isPresented)
        }
    }
}

struct FirstStartView_Previews: PreviewProvider {
    static var previews: some View {
        FirstStartView()
            .previewDevice("iPhone 12")
            .environmentObject(SOSViewModel())
            .environmentObject(InformationScreenViewModel())
            .environmentObject(ContactsViewModel())
    }
}
