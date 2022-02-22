//
//  ContactsViewModel.swift
//  SOSiety
//
//  Created by Vladislav Likh on 18/02/22.
//

import Foundation
import Contacts
import SwiftUI

class ContactsViewModel: ObservableObject {
    @Published var addedContacts: [ContactInfo] = []
    @Published var allContacts: [ContactInfo] = []
    
    func fetchingContacts(){
            var contacts = [ContactInfo]()
            let keys = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey, CNContactThumbnailImageDataKey]
            let request = CNContactFetchRequest(keysToFetch: keys as [CNKeyDescriptor])
            do {
                try CNContactStore().enumerateContacts(with: request, usingBlock: { (contact, stopPointer) in
                    contacts.append(ContactInfo(identifier: contact.identifier, firstName: contact.givenName, lastName: contact.familyName, phoneNumber: contact.phoneNumbers.first?.value))
                })
            } catch let error {
                print("Failed", error)
            }
            contacts = contacts.sorted {
                $0.firstName < $1.firstName
            }
            allContacts = contacts
        }
    
    func getContacts() {
            DispatchQueue.main.async {
                self.fetchingContacts()
            }
        }
    
    
    func requestAccess() {
            let store = CNContactStore()
            switch CNContactStore.authorizationStatus(for: .contacts) {
            case .authorized:
                self.getContacts()
            case .denied:
                store.requestAccess(for: .contacts) { granted, error in
                    if granted {
                        self.getContacts()
                    }
                }
            case .restricted, .notDetermined:
                store.requestAccess(for: .contacts) { granted, error in
                    if granted {
                        self.getContacts()
                    }
                }
            @unknown default:
                print("error")
            }

    }
}

