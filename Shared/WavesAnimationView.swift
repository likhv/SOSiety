//
//  ContentView.swift
//  Shared
//
//  Created by Vladislav Likh on 07/02/22.
//

import SwiftUI

struct SwipeButtonView: View {
    @State var swipeDistance = 0.0
    @State var swipeDistanceDelta = 0.0
    @State var isSOS = false
    @State var textOpacity = 1.0
    let drawHaptic = UIImpactFeedbackGenerator(style: .heavy)
    var red = Color(red: 223 / 255, green: 80 / 255, blue: 80 / 255)
    var white = Color(red: 248 / 255, green: 248 / 255, blue: 234 / 255)
    var circleDiameter = 80.0
    @State var notificationCountdoun = 30
//    let alarmTimer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    var body: some View {
        ZStack {
            if isSOS {
                red.ignoresSafeArea()
            } else {
                white.ignoresSafeArea()
            }
            
            if isSOS {
                WavesAnimationView(center: CGPoint(x: UIScreen.main.bounds.width-25.0-(circleDiameter/2.0), y: UIScreen.main.bounds.height/2.0-(circleDiameter/2.0)))
            }

            
            Rectangle()
                .frame(height: circleDiameter+10, alignment: .center)
                .foregroundColor(Color.black)
//                .background(.ultraThinMaterial)
//                .background(.ultraThinMaterial)
//                .cornerRadius(100)
                .clipShape(RoundedRectangle(cornerRadius: circleDiameter+10, style: .circular))
                
//                .foregroundColor(.black.opacity(0.8))
                .overlay(
                    ZStack {
                        Text(isSOS ? "Swipe left to stop" : "Swipe right to start")
                            .font(.system(size: 18, weight: .medium))
                            .foregroundColor(.white.opacity(0.3))
                            .padding(!isSOS ? .leading : .trailing, 20)
                            .animation(.easeInOut, value: isSOS)
                            .multilineTextAlignment(.center)
                            .opacity(textOpacity)
                        Circle()
                            .frame(width: circleDiameter, height: circleDiameter, alignment: .center)
                            .foregroundColor(red)
                            .overlay(
                                Text("SOS")
                                    .font(.system(size: circleDiameter/2.9, weight: .bold))
                                    .foregroundColor(.white)
                            )
                            .position(x: (circleDiameter+10)/2, y: (circleDiameter+10)/2)
                            .offset(x:swipeDistance+swipeDistanceDelta)
                            .simultaneousGesture(drag)
                    }
                )
                .padding(.horizontal, 20)
            
//            VStack {
//                Text(isSOS ? "SOS mode is started" : "Everything is ready")
//                    .font(.system(size: 36, weight: .black))
//                    .foregroundColor(.black)
//                    .padding(.trailing, 140)
//                    .padding(.top, 40)
//                Spacer()
//            }
//            .padding(.horizontal, 20)
//            if isSOS {
//                Text("Notifications in 0:30")
//                    .position(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height/2+circleDiameter/2)
//                    .font(.system(size: 18, weight: .bold))
//                    .foregroundColor(.white)
////                    .onReceive(alarmTimer) { _ in
////                        if notificationCountdoun > 10 {
////                            notificationCountdoun -= 1
////                        } else {
////                            notificationCountdoun = 30
////                        }
////                    }
//            }


        }
        
    }
    var drag: some Gesture {
        DragGesture(minimumDistance: 2.0, coordinateSpace: .global)
            .onChanged { value in
//                withAnimation(.linear(duration: 0.2)){
//                    textOpacity = 0.0
//                }
                withAnimation(.linear(duration: 0.2)){
                    
                    if value.translation.width + swipeDistance > UIScreen.main.bounds.width - 40 - 10 - circleDiameter {
                            swipeDistanceDelta = UIScreen.main.bounds.width - 40 - 10 - circleDiameter - swipeDistance
                            
                    } else if value.translation.width + swipeDistance < 5.0 {
                        swipeDistanceDelta = -swipeDistance
                    
                    } else {
                        swipeDistanceDelta = value.translation.width
                        textOpacity = 0.0
                    }

//                    if swipeDistance+swipeDistance > UIScreen.main.bounds.width - 40 - 10 - circleDiameter {
//                        swipeDistanceDelta = UIScreen.main.bounds.width - 40 - 10 - circleDiameter - circleDiameter
//                    }
                }
            }
            .onEnded { value in
                withAnimation(.spring().delay(0.2)){
                    textOpacity = 1.0
                }
                withAnimation(.easeInOut){

                    if swipeDistanceDelta + swipeDistance > UIScreen.main.bounds.width - 40 - 10 - circleDiameter - ((UIScreen.main.bounds.width-40)/2) {
                        swipeDistance = UIScreen.main.bounds.width - 40 - 10 - circleDiameter
                        isSOS = true
                        drawHaptic.impactOccurred()
                    } else {
                        swipeDistance = .zero
                        isSOS = false
                        drawHaptic.impactOccurred()
                    }
                    swipeDistanceDelta = .zero
                }
            }
    }
}

struct WavesAnimationView: View {
    @State var circlesArray: [AnimatedCircle] = []
    @State var circleWidth = 0.0
    @State var circleHeight = 0.0
    let drawHaptic = UIImpactFeedbackGenerator(style: .heavy)
    var center = CGPoint.zero
    let wavesTimer = Timer.publish(every: 5, on: .main, in: .common).autoconnect()
    var body: some View {
        ZStack {
//            Color.red.ignoresSafeArea()
            ForEach(circlesArray, id: \.id) { circle in
                circle
            }
            .onChange(of: circlesArray.count) { array in
                if array > 4 { circlesArray.remove(at: 0)}
                print(circlesArray.count)
            }
        }
        .onAppear() {
            circlesArray.append(AnimatedCircle(center:center))
        }
        
        .onReceive(wavesTimer) { input in
            circlesArray.append(AnimatedCircle(center:center))
            DispatchQueue.main.asyncAfter(deadline: .now()) {
                drawHaptic.impactOccurred()
            }
//            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
//                drawHaptic.impactOccurred()
//            }
        }

//        .onTapGesture {
//            circlesArray.append(AnimatedCircle())
//        }
    }
    func removeCircle() {
        print(circlesArray.count)
        circlesArray.remove(at: 0)
        print(circlesArray.count)
    }
}

struct AnimatedCircle: View, Identifiable {
    var id = UUID()
    var center = CGPoint.zero
    @State var circleWidthheight = 50.0
    var body: some View {
        Circle()
            .stroke(style: StrokeStyle(lineWidth: 2))
//            .strokeBorder(Color.white.opacity(0.2), lineWidth: 3)
            .frame(width: circleWidthheight, height: circleWidthheight, alignment: .center)
//            .foregroundColor(.black)
            .foregroundColor(Color(red: 200 / 255, green: 70 / 255, blue: 70 / 255))
//            .opacity(1-circleWidthheight/750)
            .position(center)
            .onAppear() {
                withAnimation(.linear(duration: 30).repeatForever()) {
                    circleWidthheight = 2000
                }
            }
//            .onChange(of: circleWidthheight) { _ in
//                if circleWidthheight > 1000.0 {
//                    circleWidthheight = 0.0
//                }
//            }
    }
}

struct AnimatedCircle2: View, Identifiable {
    var id = UUID()
    var center = CGPoint.zero
    var red = Color(red: 223 / 255, green: 80 / 255, blue: 80 / 255)
    @State var circleWidthheight = 0.0
    var body: some View {
        Circle()
            .strokeBorder(red, lineWidth: circleWidthheight/8)
            .frame(width: circleWidthheight, height: circleWidthheight, alignment: .center)
            
            .foregroundColor(.clear)
            
            .position(center)
            .opacity(1-circleWidthheight/3000)
            .shadow(color: .white.opacity(0.8), radius: 5, x: 5, y:-5)
            .shadow(color: Color(red: 120 / 255, green: 20 / 255, blue: 20 / 255), radius: 5, x: -5, y:5)
//            .blendMode(.darken)
            .blur(radius: circleWidthheight/30+3)
            .onAppear() {
                withAnimation(.linear(duration: 15).repeatForever()) {
                    circleWidthheight = 2000
                }
            }
//            .onChange(of: circleWidthheight) { _ in
//                if circleWidthheight > 1000.0 {
//                    circleWidthheight = 0.0
//                }
//            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SwipeButtonView()
    }
}
