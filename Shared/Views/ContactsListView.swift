//
//  ContactsListView.swift
//  SOSiety
//
//  Created by Vladislav Likh on 18/02/22.
//

import SwiftUI

struct ContactsListView: View {
    @EnvironmentObject var contactsViewModel: ContactsViewModel
//    var contactsList: [ContactInfo] = [ContactInfo(), ContactInfo(), ContactInfo()]
    @Binding var isPresented: Bool
    @State var searchText = ""
    var body: some View {
        NavigationView {
            ZStack {
                List() {
                    ForEach(searchResults) { contact in
                        ContactsListItemView(addedContacts: contactsViewModel.addedContacts, contact: contact)
                            .onTapGesture {
                                if let index = contactsViewModel.addedContacts.firstIndex(of: contact) {
                                    contactsViewModel.addedContacts.remove(at: index)
                                } else {
                                    contactsViewModel.addedContacts.append(contact)
                                }
                            }
                    }
                }
                .searchable(text: $searchText)
                .listStyle(.inset)
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
    var body: some View {
        ZStack {
            Color.white
            HStack {
                Text("\(contact.firstName) \(contact.lastName) ")
                    .font(.system(size: 16, weight: .medium))
                Spacer()
                if (addedContacts.contains(contact)) {
                    Image(systemName:"checkmark.circle.fill")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(Color.sosietyGreen)
                }
                //            else {
                //                Image(systemName:"checkmark.circle")
                //                    .font(.system(size: 16, weight: .bold))
                //                    .foregroundColor(.black)
                //            }
            }
            .padding(.vertical, 3)
        }
    }
}

//struct ContactsListView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContactsListView()
//    }
//}
