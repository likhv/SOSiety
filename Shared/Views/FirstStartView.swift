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
    @State var userName = ""
    @State var isContactsPresenting = false
    @Binding var firstScreenPresented: Bool
    var body: some View {
        ZStack {
            Color.sosietyPaper.ignoresSafeArea()
            if Locale.preferredLanguages[0].prefix(2) == "ru" {
                HeaderView(headerText: SOSViewModel.userName == "" ? "Как тебя зовут?" : "\(SOSViewModel.userName), выбери контакты, которые ты бы хотел уведомить в случае задержания")
            } else if Locale.preferredLanguages[0].prefix(2) == "fr" {
                HeaderView(headerText: SOSViewModel.userName == "" ? "Présente-toi. Comment t'appelles tu?" : "\(SOSViewModel.userName), sélectionne les contacts que tu souhaiterais notifier en cas de détention")
            } else {
                HeaderView(headerText: SOSViewModel.userName == "" ? "What’s your name?" : "\(SOSViewModel.userName), select contacts you’d like to notify")
            }
            
            if SOSViewModel.userName == "" {
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .stroke(.black, lineWidth: 2)
                    .frame(height: 55)
                    .foregroundColor(.black)
                    .overlay(
                        HStack {
                            TextField("Your name", text: $userName)
                                .disableAutocorrection(true)
                                .textFieldStyle(.plain)
                                .padding()
                            if userName != "" {
                                Button { SOSViewModel.userName = userName } label: {
                                    Image(systemName: "arrow.right.circle.fill")
                                        .font(.system(size: 24, weight: .medium))
                                        .foregroundColor(.black)
                                        .padding(15)
                                }
                            }
                        }).padding(25)
                    
            } else {
                Button { isContactsPresenting = true } label : {
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .frame(height: 55)
                        .foregroundColor(.black)
                        .overlay(
                            HStack {
                                Image(systemName: "person.badge.plus")
                                    .foregroundColor(.white)
                                    .font(.system(size: 18, weight: .medium))
                                if Locale.preferredLanguages[0].prefix(2) == "ru" {
                                    Text("Добавить экстренные контакты")
                                        .foregroundColor(.white)
                                        .font(.system(size: 16, weight: .medium))
                                } else if Locale.preferredLanguages[0].prefix(2) == "fr" {
                                    Text("Ajouter les contacts d’urgence")
                                        .foregroundColor(.white)
                                        .font(.system(size: 16, weight: .medium))
                                } else {
                                    Text("Select contacts")
                                        .foregroundColor(.white)
                                        .font(.system(size: 16, weight: .medium))
                                }
                                
                            }).padding(25)
                }
            }
            if contactsViewModel.addedContacts.count > 0 {
                ZStack {
                    SettingsView()
                    VStack {
                        Spacer()
                        Button { closeWindow() } label : {
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .frame(height: 55)
                                .foregroundColor(.black)
                                .overlay(
                                    HStack {
                                        Image(systemName: "person.badge.plus")
                                            .foregroundColor(.white)
                                            .font(.system(size: 18, weight: .medium))
                                        if Locale.preferredLanguages[0].prefix(2) == "ru" {
                                            Text("Сохранить контакты")
                                                .foregroundColor(.white)
                                                .font(.system(size: 16, weight: .medium))
                                        } else if Locale.preferredLanguages[0].prefix(2) == "fr" {
                                            Text("Sauvegarder les contacts")
                                                .font(.system(size: 15, weight: .regular))
                                                .padding(.top, 5)
                                        } else {
                                            Text("Save contacts")
                                                .foregroundColor(.white)
                                                .font(.system(size: 16, weight: .medium))
                                        }
                                        
                                    }).padding(25)
                        }
                    }
                }
            }
        }
        .sheet(isPresented: $isContactsPresenting) {
            ContactsListView(isPresented: $isContactsPresenting)
        }
    }
    func closeWindow() {
        if contactsViewModel.addedContacts.count > 0 { firstScreenPresented = false }
    }
}





struct FirstStartEnterNameView: View {
    @EnvironmentObject var SOSViewModel: SOSViewModel
    @Binding var nameAdded: Bool
    var body: some View {
        HStack {
            Text("What’s your name?")
                .font(.system(size: 38, weight: .bold))
                .multilineTextAlignment(.leading)
                .foregroundColor(.black)
            //                .padding(.leading, 24)
                .padding(.top, 30)
                .padding(.horizontal, 20)
            Spacer()
        }
        
        
        
        //        VStack(alignment: .leading, spacing: 20) {
        //
        //            Text("Let's start with introductions.\nWhat’s your name?")
        //                .foregroundColor(.black)
        //                .font(.title)
        //                .fontWeight(.bold)
        //                .padding(.horizontal, 2)
        //                .padding(.bottom, 30)
        //            RoundedRectangle(cornerRadius: 10, style: .continuous)
        //                .stroke(.black, lineWidth: 2)
        //                .frame(height: 55)
        ////                .foregroundColor(Color(.systemGray5))
        //                .foregroundColor(.black)
        //                .overlay(
        //                    HStack {
        //                        TextField(
        //                                "Your name",
        //                                text: $SOSViewModel.userName
        //                            )
        //                            .disableAutocorrection(true)
        //                            .textFieldStyle(.plain)
        //                            .padding()
        //                        if SOSViewModel.userName != "" {
        //                            Button { nameAdded = true } label: {
        //                                Image(systemName: "arrow.right.circle.fill")
        //                                    .font(.system(size: 24, weight: .medium))
        //                                    .foregroundColor(.black)
        //                                    .padding(15)
        //                            }
        //                        }
        //                    }
        //                    )
        //            Spacer()
        //        }
        //        .padding(.top, 100)
        //        .padding(.horizontal, 30)
    }
}

struct FirstStartAddContactView: View {
    @EnvironmentObject var SOSViewModel: SOSViewModel
    @EnvironmentObject var contactsViewModel: ContactsViewModel
    @State private var isPresented = false
    @Binding var nameAdded: Bool
    var body: some View {
        VStack(alignment: .leading, spacing: 50) {
            
            Text("\(SOSViewModel.userName), select contacts you’d like to notify")
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
                                Text("Select contacts")
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

//struct FirstStartView_Previews: PreviewProvider {
//    static var previews: some View {
//        FirstStartView()
//            .previewDevice("iPhone 12")
//            .environmentObject(SOSViewModel())
//            .environmentObject(InformationScreenViewModel())
//            .environmentObject(ContactsViewModel())
//    }
//}
