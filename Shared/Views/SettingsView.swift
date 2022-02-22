//
//  ContentViewNatasha.swift
//  SOSiety
//
//  Created by Vladislav Likh on 14/02/22.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var contactsViewModel: ContactsViewModel
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
        .navigationTitle("Settings")
//        .navigationBackButton(color: .black, text: "Back")
        .fullScreenCover(isPresented: $isPresented) {
            ContactsListView(isPresented: $isPresented)
        }
    }
}

struct AddedContactsListView: View {
    @EnvironmentObject var contactsViewModel: ContactsViewModel
    @State var searchText = ""
    @Binding var isPresented: Bool
    var body: some View {
        ZStack {
            List() {
                ForEach($contactsViewModel.addedContacts) { contact in
                    SettingsContactsListItemView(contact: contact)
                }
                .onDelete(perform: delete)
            }
            .listStyle(.insetGrouped)
            if contactsViewModel.addedContacts.count == 0 {
                Button {isPresented = true} label: {
                    VStack (alignment: .center, spacing: 2) {
                        Image(systemName: "person.badge.plus")
                            .font(.system(size: 60, weight: .bold))
                            .multilineTextAlignment(.center)
                            .foregroundColor(.black)
                            .padding(10)
                        Text("No contacts yet")
                            .font(.system(size: 26, weight: .bold))
                            .multilineTextAlignment(.center)
                            .foregroundColor(.black)
                        Text("Tap to add at least one person")
                            .font(.system(size: 18, weight: .medium))
                            .multilineTextAlignment(.center)
                            .foregroundColor(.black)
                    }
                    .padding(.bottom, 50)
                }
                .padding(.horizontal, 45)
            }
        }
    }
    func delete(at offsets: IndexSet) {
        contactsViewModel.addedContacts.remove(atOffsets: offsets)
    }
}

struct SettingsContactsListItemView: View {
    @Binding var contact: ContactInfo
    var body: some View {
        HStack(spacing: 10) {
//            contact.image
//                .resizable()
//                .frame(width: 50, height: 50, alignment: .center)
//                .scaledToFit()
//                .mask(Circle())
//            Circle()
//                .frame(width: 40, height: 40, alignment: .center)
//                .overlay(
//                    contact.image
//
//                    )
            VStack(alignment: .leading, spacing: 5) {
                if contact.firstName == "" {
                    Text("\(contact.lastName)")
                        .font(.system(size: 18, weight: .semibold))
                } else {
                    Text("\(contact.firstName)\(contact.lastName)")
                        .font(.system(size: 18, weight: .semibold))
                }
                if contact.phoneNumber != nil {
                    Text("\(contact.phoneNumber!.stringValue)")
                        .font(.system(size: 15, weight: .regular))
                } else {
                    Text("No phone number")
                        .font(.system(size: 15, weight: .regular))
                }
                HStack {
                    Text("Share location")
                        .font(.system(size: 15, weight: .regular))
                        .padding(.top, 5)
                    Toggle("", isOn: $contact.isLocationShared)
                }
                    
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


