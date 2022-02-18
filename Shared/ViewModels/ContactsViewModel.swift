//
//  ContactsViewModel.swift
//  SOSiety
//
//  Created by Vladislav Likh on 18/02/22.
//

import Foundation

class ContactsViewModel: ObservableObject {
    @Published var addedContacts: [Contact] = []
}
