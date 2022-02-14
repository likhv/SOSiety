//
//  InformationView.swift
//  SOSiety
//
//  Created by Vladislav Likh on 14/02/22.
//

import SwiftUI

struct InformationView: View {
    @Binding var isPresenting: Bool
    var body: some View {
        ZStack {
            Color.sosietyPaper.ignoresSafeArea()
            InstructionView()
            Button {isPresenting = false} label: {
                Image(systemName: "multiply")
                    .foregroundColor(.black)
                    .font(.system(size: 20))
                    .position(x: 32, y: 22)
            }
        }
    }
}

struct InstructionView: View {
    var body: some View {
        VStack {
            Image(systemName: "checklist").resizable().scaledToFit().padding()
            Text("Start with adding emergency contacts")
                .font(.largeTitle).fontWeight(.bold)
            Text("Add contacts from the phonebook or choose human rights organisation to notify them in case of arrest.").font(.title3)
                .padding()
        }
    }
}

struct InformationView_Previews: PreviewProvider {
    static var previews: some View {
        MainScreenView(isPresenting: true)
            .environmentObject(ViewModel())
    }
}
