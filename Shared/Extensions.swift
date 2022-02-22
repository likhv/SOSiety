//
//  Extensions.swift
//  SOSiety
//
//  Created by Vladislav Likh on 14/02/22.
//

import Foundation
import SwiftUI

extension Color {
    static let sosietyRed = Color(red: 223 / 255, green: 80 / 255, blue: 80 / 255)
    static let sosietyPaper = Color.white
//    static let sosietyPaper = Color(red: 248 / 255, green: 248 / 255, blue: 234 / 255)
    static let sosietyGreen = Color(red: 45 / 255, green: 190 / 255, blue: 156 / 255)
}

//struct NavigationBackButton: ViewModifier {
//
//    @Environment(\.presentationMode) var presentationMode
//    var color: UIColor
//    var text: String?
//
//    func body(content: Content) -> some View {
//        return content
//            .navigationBarBackButtonHidden(true)
//            .navigationBarItems(
//                leading: Button(action: {  presentationMode.wrappedValue.dismiss() }, label: {
//                    HStack(spacing: 2) {
//                        Image(systemName: "chevron.backward")
//                            .font(.system(size: 16, weight: .semibold))
//                            .foregroundColor(Color(color))
//
//                        if let text = text {
//                            Text(text)
//                                .foregroundColor(Color(color))
//                                .font(.system(size: 16, weight: .semibold))
//                        }
//                    }
//                })
//            )
//    }
//}
//
//extension View {
//    func navigationBackButton(color: UIColor, text: String? = nil) -> some View {
//        modifier(NavigationBackButton(color: color, text: text))
//    }
//}
