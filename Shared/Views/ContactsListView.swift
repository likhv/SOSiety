//
//  ContactsListView.swift
//  SOSiety
//
//  Created by Vladislav Likh on 18/02/22.
//

import SwiftUI

struct ContactsListView_preview: View {
    @State var isPresented: Bool = true
    var body: some View {
        ContactsListView(isPresented: $isPresented)
    }
}

struct ContactsListView: View {
    @Environment(\.dismissSearch) private var dismissSearch
    @EnvironmentObject var contactsViewModel: ContactsViewModel
    @Binding var isPresented: Bool
    @State var searchText = ""
    @State var searchOn = true
    var body: some View {
        NavigationView {
            ZStack {
                VStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .frame(height: 40)
                        .opacity(0.15)
                        .foregroundColor(.gray)
                        .onTapGesture() {
                            searchOn = true
                        }
                        .overlay(
                            HStack {
                                if searchOn {
                                    TextField("Search", text: $searchText)
                                        .foregroundColor(.black)
                                    Spacer()
                                    if searchText != "" {
                                        Button {
                                            searchText = ""
//                                            searchOn = false
                                            
                                        } label: {
                                            Image(systemName: "xmark.circle.fill")
                                                .font(.system(size: 20, weight: .medium))
                                                .foregroundColor(.black)
                                        }
                                    }
                                }
                            }
                            .padding(.horizontal, 10)
                        )
                        .padding(16)
                    ForEach(contactsViewModel.addedContacts) { contact in
                        Divider()
                        Button {
                            if let index = contactsViewModel.addedContacts.firstIndex(where: { $0.identifier == contact.identifier }) {
                                contactsViewModel.addedContacts.remove(at: index) }
                        } label: {
                            ContactsListItemViewAdded(contact: contact)
                        }
                    }
                        .padding(.leading, 20)
                    Divider()
                        .padding(.leading, 20)
                    List() {
                        ForEach(searchResults.filter { $0.firstName != "" || $0.lastName != "" } ) { contact in
                            if !contactsViewModel.addedContacts.contains { $0.identifier == contact.identifier}  {
                                Button {
                                    if let index = contactsViewModel.addedContacts.firstIndex(where: { $0.identifier == contact.identifier }) {
                                        contactsViewModel.addedContacts.remove(at: index)
                                    } else {
                                        if contactsViewModel.addedContacts.count < 5 {
                                            contactsViewModel.addedContacts
                                                .append(contact)
                                            dismissSearch()
                                            
                                        }
                                    }
                                } label: {
                                    ContactsListItemView(addedContacts: contactsViewModel.addedContacts, contact: contact, isAdded: contactsViewModel.addedContacts.contains { $0.identifier == contact.identifier})
                      
                                }
                            }
                        }
                    }
//                    .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
                    .listStyle(.inset)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
    //                ToolbarItem(placement: .navigationBarLeading) {
    //                    Button {} label: {
    //                        Text("Cancel")
    //                            .foregroundColor(.black)
    //                    }
    //                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button { isPresented = false } label: {
                        Text("Save")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.black)
                    }
                }
            }
            .onAppear {
                contactsViewModel.requestAccess()
            }

        }

    }
    var searchResults: [ContactInfo] {
        if searchText.isEmpty {
            return contactsViewModel.allContacts
        } else {
            return contactsViewModel.allContacts.filter { $0.firstName.contains(searchText) || $0.lastName.contains(searchText)}
        }
    }
}

struct ContactsListItemView: View {
    var addedContacts: [ContactInfo]
    var contact: ContactInfo
    var isAdded: Bool
    var body: some View {
            HStack {
                Text("\(contact.firstName) \(contact.lastName) ")
                    .font(.system(size: 16, weight: .medium))
                Spacer()
                Image(systemName:"checkmark.circle.fill")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(Color.sosietyGreen)
                    .opacity(isAdded ? 1 : 0)
                //            else {
                //                Image(systemName:"checkmark.circle")
                //                    .font(.system(size: 16, weight: .bold))
                //                    .foregroundColor(.black)
                //            }
            }
            .padding(.vertical, 6)
//        .onAppear() {
//            isAdded = addedContacts.contains(contact)
//        }
    }
}

struct ContactsListItemViewAdded: View {
    var contact: ContactInfo
    var isAdded: Bool = true
    var body: some View {
            HStack {
                Text("\(contact.firstName) \(contact.lastName) ")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(Color.black)
                Spacer()
                Image(systemName:"checkmark.circle.fill")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(Color.sosietyGreen)
                    .opacity(isAdded ? 1 : 0)
                    .padding(.trailing, 25)
                //            else {
                //                Image(systemName:"checkmark.circle")
                //                    .font(.system(size: 16, weight: .bold))
                //                    .foregroundColor(.black)
                //            }
            }
            .padding(.vertical, 6)
//        .onAppear() {
//            isAdded = addedContacts.contains(contact)
//        }
    }
}


struct ContactsListView_Previews: PreviewProvider {
    static var previews: some View {
        ContactsListView_preview()
            .environmentObject(SOSViewModel())
            .environmentObject(InformationScreenViewModel())
            .environmentObject(ContactsViewModel())
    }
}
