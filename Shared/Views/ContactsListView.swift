//
//  ContactsListView.swift
//  SOSiety
//
//  Created by Vladislav Likh on 18/02/22.
//

import SwiftUI

struct ContactsListView: View {
    @EnvironmentObject var contactsViewModel: ContactsViewModel
    var contactsList: [ContactInfo] = [ContactInfo(), ContactInfo(), ContactInfo()]
    var body: some View {
        List() {
            ForEach(contactsViewModel.allContacts) { contact in
                ContactsListItemView(contact: contact)
                    .onTapGesture {
                        
                        if let index = contactsViewModel.addedContacts.firstIndex(of: contact) {
                            contactsViewModel.addedContacts.remove(at: index)
                        } else {
                            contactsViewModel.addedContacts.append(contact)
                        }
                    }
            }
        }
        .onAppear {
            contactsViewModel.requestAccess()
        }
    }
}

struct ContactsListItemView: View {
    var contact: ContactInfo
    @EnvironmentObject var contactsViewModel: ContactsViewModel
    var body: some View {
        HStack {
            Text("\(contact.firstName) \(contact.lastName) ")
                .font(.system(size: 16, weight: .medium))
            Spacer()
            if (contactsViewModel.addedContacts.filter({$0 == contact}).first != nil) {
                Image(systemName:"checkmark.circle.fill")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.black)
            } else {
                Image(systemName:"checkmark.circle")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.black)
            }
        }
    }
}

struct ContactsListView_Previews: PreviewProvider {
    static var previews: some View {
        ContactsListView()
    }
}
