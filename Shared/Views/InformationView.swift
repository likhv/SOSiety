//
//  InformationView.swift
//  SOSiety
//
//  Created by Vladislav Likh on 14/02/22.
//

import SwiftUI

struct InformationView: View {
    var body: some View {
        VStack {
            Image(systemName: "checklist").resizable().scaledToFit().padding()
            Text("Start with adding emergency contacts")
                .font(.largeTitle).fontWeight(.bold)
            Text("Add contacts from the phonebook or choose human rights organisation to notify them in case of arrest.").font(.title3)
                .padding()
        }
        .navigationTitle("How the app works")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct InformationView_Previews: PreviewProvider {
    static var previews: some View {
        InformationView()
    }
}
