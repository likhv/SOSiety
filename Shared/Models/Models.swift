//
//  ContactModel.swift
//  SOSiety
//
//  Created by Vladislav Likh on 18/02/22.
//

import Foundation

struct InformationScreen: Identifiable {
    let id = UUID()
    let icon: String
    let heading: String
    let description: String
}

struct Advice: Identifiable {
    var id = UUID()
    var title = "Some title here"
    var text = "If you aren’t sure about documents officers ask you to sign, try not to do that. It is also important with empty blanks"
}

struct Contact: Identifiable {
    var id = UUID()
    var name = "Natalie"
    var surname = "Portman"
    var phoneNumber = 89164477148
}
