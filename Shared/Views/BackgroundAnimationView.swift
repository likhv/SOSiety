//
//  WavesAnimation.swift
//  SOSiety
//
//  Created by Vladislav Likh on 21/02/22.
//

import SwiftUI

struct LoopedWaveAnimationView: View {
    var center = CGPoint.zero
    var body: some View {
        ZStack {
//            Color.black.ignoresSafeArea()
            loopedWave(delay: 0.5, center: center)
            loopedWave(delay: 2.5, center: center)
            loopedWave(delay: 4.5, center: center)
            loopedWave(delay: 6.5, center: center)
        }
//        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
//        .ignoresSafeArea()
    }
}

struct loopedWave: View {
    @State var firstCircleWidthheight = 0.0
    var delay = 0.0
    var center: CGPoint
    var body: some View {
        Circle()
            .stroke(style: StrokeStyle(lineWidth: 1))
            .frame(width: firstCircleWidthheight, height: firstCircleWidthheight, alignment: .center)
            .foregroundColor(.white.opacity(1))
            .position(center)
            .opacity(1.0-(firstCircleWidthheight/1000))
            .onAppear() {
                withAnimation(.linear(duration: 8).repeatForever(autoreverses: false).delay(delay)) {
                    firstCircleWidthheight = 1500
                }
            }
    }
}

struct WavesAnimation_Previews: PreviewProvider {
    static var previews: some View {
        LoopedWaveAnimationView()
    }
}
