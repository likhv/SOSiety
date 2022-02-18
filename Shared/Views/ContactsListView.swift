//
//  ContactsListView.swift
//  SOSiety
//
//  Created by Vladislav Likh on 18/02/22.
//

import SwiftUI

struct ContactsListView: View {
    var contactsList: [Contact] = [Contact(), Contact(), Contact()]
    var body: some View {
        List() {
            ForEach(contactsList) { contact in
                ContactsListItemView(contact: contact)
            }
        }
    }
}

struct ContactsListItemView: View {
    var contact: Contact
    var body: some View {
        HStack {
            Text("\(contact.name) \(contact.surname)")
                .font(.system(size: 16, weight: .medium))
            Spacer()
            Image(systemName: "checkmark.circle.fill")
                .font(.system(size: 16, weight: .bold))
                .foregroundColor(.black)
        }
    }
}

struct ContactsListView_Previews: PreviewProvider {
    static var previews: some View {
        ContactsListView()
    }
}
