//
//  FirstStartView.swift
//  SOSiety
//
//  Created by Vlad Likh on 23.02.2022.
//

import SwiftUI
import Alamofire

struct FirstStartView: View {
    @EnvironmentObject var informationScreenViewModel: InformationScreenViewModel
    @EnvironmentObject var contactsViewModel: ContactsViewModel
    @EnvironmentObject var SOSViewModel: SOSViewModel
    @State var nameAdded = false
    var body: some View {
            ZStack {
                Color.sosietyPaper.ignoresSafeArea()
                        if !nameAdded {
                            FirstStartEnterNameView(nameAdded: $nameAdded)
                        } else {
                            SettingsView()
                            if contactsViewModel.allContacts.count != 0 {
                                VStack {
                                    Spacer()
                                    Button { SOSViewModel.isFirstStart = false } label: {
                                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                                            .frame(height: 55)
                                            .overlay(
                                                Text("Save settings")
                                                    .foregroundColor(.white)
                                            )
                                            .padding(25)
                                            .padding(.bottom, 40)
                                    }
                                }
                            }
//                            FirstStartAddContactView(nameAdded: $nameAdded)
                        }
                    }
        
               
            
            .tabViewStyle(.page)
            .indexViewStyle(.page(backgroundDisplayMode: .always))
//            .navigationTitle("How the app works")
            .navigationBarTitleDisplayMode(.inline)
        }
    
}

struct FirstStartEnterNameView: View {
    @EnvironmentObject var SOSViewModel: SOSViewModel
    @Binding var nameAdded: Bool
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {

            Text("Let's start with introductions.\nWhat’s your name?")
                .foregroundColor(.black)
                .font(.title)
                .fontWeight(.bold)
                .padding(.horizontal, 2)
                .padding(.bottom, 30)
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .stroke(.black, lineWidth: 2)
                .frame(height: 55)
//                .foregroundColor(Color(.systemGray5))
                .foregroundColor(.black)
                .overlay(
                    HStack {
                        TextField(
                                "Your name",
                                text: $SOSViewModel.userName
                            )
                            .disableAutocorrection(true)
                            .textFieldStyle(.plain)
                            .padding()
                        if SOSViewModel.userName != "" {
                            Button { nameAdded = true } label: {
                                Image(systemName: "arrow.right.circle.fill")
                                    .font(.system(size: 24, weight: .medium))
                                    .foregroundColor(.black)
                                    .padding(15)
                            }
                        }
                    }
                    )
            Spacer()
        }
        .padding(.top, 100)
        .padding(.horizontal, 30)
    }
}

struct FirstStartAddContactView: View {
    @EnvironmentObject var SOSViewModel: SOSViewModel
    @EnvironmentObject var contactsViewModel: ContactsViewModel
    @State private var isPresented = false
    @Binding var nameAdded: Bool
    var body: some View {
        VStack(alignment: .leading, spacing: 50) {

            Text("\(SOSViewModel.userName),\nlet's choose contacts\nyou want to inform")
                .foregroundColor(.black)
                .font(.title)
                .fontWeight(.bold)
                .padding(.horizontal, 2)
            if contactsViewModel.allContacts.count == 0 {
                
                Button { isPresented = true } label : {
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .frame(height: 55)
                        .foregroundColor(.black)
                        .overlay(
                            HStack {
                                Image(systemName: "person.badge.plus")
                                    .foregroundColor(.white)
                                    .font(.system(size: 18, weight: .medium))
                                Text("Choose contacts")
                                    .foregroundColor(.white)
                                    .font(.system(size: 16, weight: .medium))
                            }
                        )
                        
                }
            } else {
                List() {
                    ForEach($contactsViewModel.addedContacts) { contact in
                        SettingsContactsListItemView(contact: contact)
                    }
                }
                
            }
            Spacer()
        }
        .padding(.top, 100)
        .padding(.horizontal, 30)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button { nameAdded = false } label: {
                    Text("Change name")
                        .font(.system(size: 16, weight: .regular))
                        .foregroundColor(.gray)
                }
            }
        }
        .fullScreenCover(isPresented: $isPresented) {
            ContactsListView(isPresented: $isPresented)
        }
    }
}

struct FirstStartView_Previews: PreviewProvider {
    static var previews: some View {
        FirstStartView()
            .previewDevice("iPhone 12")
            .environmentObject(SOSViewModel())
            .environmentObject(InformationScreenViewModel())
            .environmentObject(ContactsViewModel())
    }
}
