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
            AddedContactsListView()
        }
        .navigationTitle("Settings")
        .fullScreenCover(isPresented: $isPresented) {
            ContactsListView(isPresented: $isPresented)
        }
    }
}

struct AddedContactsListView: View {
    @EnvironmentObject var contactsViewModel: ContactsViewModel
    @State var searchText = ""
    var body: some View {
        List() {
            ForEach(contactsViewModel.addedContacts) { contact in
                SettingsContactsListItemView(contact: contact)
            }
        }
        .listStyle(.insetGrouped)
    }
}

struct SettingsContactsListItemView: View {
    var contact: ContactInfo
    var body: some View {
        HStack(spacing: 10) {
            contact.image
                .resizable()
                .frame(width: 50, height: 50, alignment: .center)
                .scaledToFit()
                .mask(Circle())
//            Circle()
//                .frame(width: 40, height: 40, alignment: .center)
//                .overlay(
//                    contact.image
//
//                    )
            VStack(alignment: .leading, spacing: 0) {
                Text("\(contact.firstName) \(contact.lastName) ")
                    .font(.system(size: 18, weight: .semibold))
                Text("\(contact.phoneNumber.stringValue)")
                    .font(.system(size: 15, weight: .regular))
            }
        }
        .padding(.vertical, 6)
    }
}



struct ContentView_PreviewsSettings: PreviewProvider {
    static var previews: some View {
        MainScreenView()
            .environmentObject(ViewModel())
            .environmentObject(InformationScreenViewModel())
            .environmentObject(ContactsViewModel())
            .previewDevice("iPhone 11")
    }
}


