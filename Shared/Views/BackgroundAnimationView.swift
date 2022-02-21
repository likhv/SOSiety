//
//  WavesAnimation.swift
//  SOSiety
//
//  Created by Vladislav Likh on 21/02/22.
//

import SwiftUI

struct LoopedWaveAnimationView: View {
    @State var firstCircleWidthheight = 0.0
    @State var secondCircleWidthheight = 0.0
    @State var thirdCircleWidthheight = 0.0
    var center = CGPoint.zero
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            Circle()
                .stroke(style: StrokeStyle(lineWidth: 1))
                .frame(width: firstCircleWidthheight, height: firstCircleWidthheight, alignment: .center)
                .foregroundColor(.white.opacity(0.75))
                .position(center)
                .opacity(1.0-(firstCircleWidthheight/1500))
                .onAppear() {
                    withAnimation(.linear(duration: 5).repeatForever(autoreverses: false)) {
                        firstCircleWidthheight = 1500
                    }
                }
        }
        .ignoresSafeArea()

    }
}

struct WavesAnimation_Previews: PreviewProvider {
    static var previews: some View {
        LoopedWaveAnimationView()
    }
}
