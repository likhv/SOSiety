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
                ForEach(informationScreenViewModel.informationScreens, id:\.id) {informationScreen in
                    InformationItem(informationScreen: informationScreen)
                }
                FirstStartViewAddContact()
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

struct FirstStartViewAddContact: View {
    @State private var isPresented = false
    var body: some View {
        VStack {
            HStack {
                Text ("Emergency contacts")
                    .font(.title2).bold()
                Spacer()
                Button {
                    isPresented.toggle()
                } label: {
                    Image(systemName: "plus")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.black)
                }
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 10)
            AddedContactsListView(isPresented: $isPresented)
        }
    }
}

struct FirstStartView_Previews: PreviewProvider {
    static var previews: some View {
        FirstStartView()
            .previewDevice("iPhone 12")
            .environmentObject(ViewModel())
            .environmentObject(InformationScreenViewModel())
            .environmentObject(ContactsViewModel())
    }
}
