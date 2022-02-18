//
//  ContactsListView.swift
//  SOSiety
//
//  Created by Vladislav Likh on 18/02/22.
//

import SwiftUI

struct ContactsListView_NavigationPreview: View {
    var body: some View {
        NavigationView {
            ContactsListView()
        }
    }
}

struct ContactsListView: View {
    var contactsList: [Contact] = [Contact(), Contact(), Contact()]
    @State var searchText = ""
    var body: some View {
        VStack {
//            SearchBar(text: $searchText)
            List() {
                ForEach(contactsList) { contact in
                    ContactsListItemView(contact: contact)
                }
            }
            .searchable(text: $searchText)
            .listStyle(.inset)
        }
        
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {} label: {
                    Text("Cancel")
//                        .font(.system(size: 16, weight: .bold))
//                        .foregroundColor(.black)
                }
            }
//            ToolbarItem(placement: .principal) {
//                Text("#SOSiety")
//                    .font(.system(size: 20, weight: .bold))
//                    .foregroundColor(.black)
//            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {} label: {
                    Text("Save")
//                        .font(.system(size: 16, weight: .bold))
//                        .foregroundColor(.black)
                }
           }
        }
    }
}

struct ContactsListItemView: View {
    var contact: Contact
    var body: some View {
        HStack {
            Text("\(contact.name) \(contact.surname)")
                .font(.system(size: 18, weight: .medium))
            Spacer()
            Image(systemName: "checkmark.circle.fill")
                .font(.system(size: 18, weight: .bold))
                .foregroundColor(.black)
        }
        .padding(.vertical, 4)
    }
}

struct SearchBar: View {
    @Binding var text: String
    @State private var isEditing = false
 
    var body: some View {
        HStack {
 
            TextField("Search...", text: $text)
                .padding(7)
//                .padding(.horizontal, 25)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .padding(.horizontal, 10)
                .onTapGesture {
                    self.isEditing = true
                }
 
            if isEditing {
                Button(action: {
                    self.isEditing = false
                    self.text = ""
 
                }) {
                    Text("Cancel")
                }
                .padding(.trailing, 10)
                .transition(.move(edge: .trailing))
//                .animation(.default)
            }
        }
    }
}

struct ContactsListView_Previews: PreviewProvider {
    static var previews: some View {
        ContactsListView_NavigationPreview()
    }
}
