//
//  ContentView.swift
//  Shared
//
//  Created by Vladislav Likh on 07/02/22.
//

import SwiftUI

struct MainScreenView: View {
    @EnvironmentObject var viewModel: ViewModel
    @State var isInfoPresenting = false
    @State var isFAQOpened = false
    @State var FAQHeight = 0.0
    @State var tumblerOffset = 0.0
    @State var headerOpacity = 1.0
    var body: some View {
        NavigationView {
            ZStack {
                if viewModel.isSOS {
                    Color.sosietyRed.ignoresSafeArea()
                } else {
                    Color.sosietyPaper.ignoresSafeArea()
                }

                TumblerView(isSOS: $viewModel.isSOS, isFAQOpened: $isFAQOpened)
                    .offset(y: tumblerOffset)
                HeaderView(isSOS: viewModel.isSOS)
                    .opacity(headerOpacity)
                    .offset(y: tumblerOffset/4)
                VStack {
                    Spacer()
                    Button { toggleFAQ() } label: {
                        VStack {
                            Text("What's next")
                                .font(.system(size: 18, weight: .semibold))
                                .padding(.bottom, 5)
                            Image(systemName: "chevron.down")
                                .font(.system(size: 18, weight: .semibold))
                        }
                    }
                }
                FAQView(isFAQPresenting: $isFAQOpened)
                    .opacity(1-headerOpacity)
                    .offset(y: (UIScreen.main.bounds.height/3 + tumblerOffset) * 1.5)
            }
            .navigationTitle("#SOSiety")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(
                leading:
                    Button {isInfoPresenting = true} label: {
                        Image(systemName: "info.circle")},
                trailing:
                    NavigationLink(destination: SettingsView(), label: {
                        Image(systemName: "gearshape")
                    }))
            .accentColor(.black)
            .fullScreenCover(isPresented: $isInfoPresenting) {
                InformationView(isInfoPresenting: $isInfoPresenting)
            }
        }
    }
    func toggleFAQ() {
        withAnimation(.spring()) {
            if isFAQOpened {
                isFAQOpened = false
                tumblerOffset = 0
                headerOpacity = 1.0
            } else {
                isFAQOpened = true
                tumblerOffset -= UIScreen.main.bounds.height/3
                headerOpacity = 0.0
            }
//            FAQHeight = UIScreen.main.bounds.height - 250.0
        }
    }
    
}

struct FAQView: View {
    @EnvironmentObject var viewModel: ViewModel
    @Binding var isFAQPresenting: Bool
    var body: some View {
        VStack {
            Rectangle()
                .frame(width: UIScreen.main.bounds.width-42, height: UIScreen.main.bounds.width-42, alignment: .center)
                .clipShape(RoundedRectangle(cornerRadius: 10, style: .circular))
                .foregroundColor(.sosietyPaper)
                .overlay(
                    VStack(alignment: .leading) {
                        Text("Tile")
                        Text("Text here")
                    }
                )
//            Spacer()
//            Button { viewModel.openFAQ() } label: {
//                VStack {
//                    Text("What's next")
//                        .font(.system(size: 18, weight: .semibold))
//                        .padding(.bottom, 5)
//                    Image(systemName: "chevron.down")
//                        .font(.system(size: 18, weight: .semibold))
//                }
//            }
        }
    }
}

struct TumblerView: View {
    @EnvironmentObject var viewModel: ViewModel
    @Binding var isSOS: Bool
    @Binding var isFAQOpened: Bool
    @State var swipeDistance = 0.0
    @State var swipeDistanceDelta = 0.0
    @State var textOpacity = 1.0
    let drawHaptic = UIImpactFeedbackGenerator(style: .heavy)
    var circleDiameter = 80.0
    var body: some View {
        ZStack {
            if isSOS {
                WavesAnimationView(center: CGPoint(x: UIScreen.main.bounds.width-25.0-(circleDiameter/2.0), y: UIScreen.main.bounds.height/2.0+(circleDiameter/2.0)-10))
                    .ignoresSafeArea()
            }
            Rectangle()
                .frame(height: circleDiameter+10, alignment: .center)
                .foregroundColor(Color.black)
                .clipShape(RoundedRectangle(cornerRadius: circleDiameter+10, style: .circular))
                .overlay(
                    ZStack {
                        Text(isSOS ? "Swipe left to stop" : "Swipe right to start")
                            .font(.system(size: 18, weight: .regular))
                            .foregroundColor(.sosietyPaper.opacity(0.8))
                            .padding(!isSOS ? .leading : .trailing, 10)
                            .animation(.easeInOut, value: isSOS)
                            .multilineTextAlignment(.center)
                            .opacity(textOpacity)
                        Circle()
                            .frame(width: circleDiameter, height: circleDiameter, alignment: .center)
                        //  .foregroundColor(Color.sosietyRed)
                            .foregroundColor(isSOS ? Color.sosietyRed : Color.sosietyPaper)
                            .overlay(
                                Text("SOS")
                                    .font(.system(size: circleDiameter/2.9, weight: .bold))
                                //  .foregroundColor(.white)
                                    .foregroundColor(isSOS ? .white : .black)
                            )
                            .position(x: (circleDiameter+10)/2, y: (circleDiameter+10)/2)
                            .offset(x:swipeDistance+swipeDistanceDelta)
                            .simultaneousGesture(drag)
                    })
                .padding(.horizontal, 20)
                .ignoresSafeArea()
        }
    }
    var drag: some Gesture {
        DragGesture(minimumDistance: 2.0, coordinateSpace: .global)
            .onChanged { value in
                withAnimation(.linear(duration: 0.2)){
                    
                    if value.translation.width + swipeDistance > UIScreen.main.bounds.width - 40 - 10 - circleDiameter {
                        swipeDistanceDelta = UIScreen.main.bounds.width - 40 - 10 - circleDiameter - swipeDistance
                        
                    } else if value.translation.width + swipeDistance < 5.0 {
                        swipeDistanceDelta = -swipeDistance
                        
                    } else {
                        swipeDistanceDelta = value.translation.width
                        textOpacity = 0.0
                    }
                }
            }
            .onEnded { value in
                withAnimation(.spring().delay(0.2)){
                    textOpacity = 1.0
                }
                withAnimation(.easeInOut){
                    if swipeDistanceDelta + swipeDistance > UIScreen.main.bounds.width - 40 - 10 - circleDiameter - ((UIScreen.main.bounds.width-40)/2) {
                        swipeDistance = UIScreen.main.bounds.width - 40 - 10 - circleDiameter
                        viewModel.startSOS()
                        drawHaptic.impactOccurred()
                    } else {
                        swipeDistance = .zero
                        viewModel.stopSOS()
                        drawHaptic.impactOccurred()
                    }
                    swipeDistanceDelta = .zero
                }
            }
    }
}

struct HeaderView: View {
    var isSOS: Bool
    var headerText: String {isSOS ? "SOS mode\nlaunched" : "Everything\nis ready"}
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(headerText)
                    .font(.system(size: 38, weight: .bold))
                    .multilineTextAlignment(.leading)
                    .padding(.leading, 24)
                    .padding(.top, 30)
                    .padding(.trailing, 60)
                Spacer()
            }
            Spacer()
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
            ForEach(circlesArray, id: \.id) { circle in
                circle
            }
            .onChange(of: circlesArray.count) { array in
                if array > 4 { circlesArray.remove(at: 0)}
                print(circlesArray.count)
            }
        }
        .ignoresSafeArea()
        .onAppear() {
            if circlesArray.count == 0 {
                circlesArray.append(AnimatedCircle(center:center))
            }
        }
        .onReceive(wavesTimer) { input in
            circlesArray.append(AnimatedCircle(center:center))
            DispatchQueue.main.asyncAfter(deadline: .now()) {
                drawHaptic.impactOccurred()
            }
        }
    }
    func removeCircle() {
        print(circlesArray.count)
        circlesArray.remove(at: 0)
        print(circlesArray.count)
    }
}

struct AnimatedCircle: View, Identifiable {
    @State var circleWidthheight = 50.0
    var id = UUID()
    var center = CGPoint.zero
    var body: some View {
        Circle()
            .stroke(style: StrokeStyle(lineWidth: 1))
            .frame(width: circleWidthheight, height: circleWidthheight, alignment: .center)
            .foregroundColor(.sosietyPaper.opacity(0.5))
            .position(center)
            .onAppear() {
                withAnimation(.linear(duration: 30).repeatForever()) {
                    circleWidthheight = 2000
                }
            }
    }
}

struct AnimatedCircle3D: View, Identifiable {
    @State var circleWidthheight = 0.0
    var id = UUID()
    var center = CGPoint.zero
    var red = Color(red: 223 / 255, green: 80 / 255, blue: 80 / 255)
    var body: some View {
        Circle()
            .strokeBorder(red, lineWidth: circleWidthheight/8)
            .frame(width: circleWidthheight, height: circleWidthheight, alignment: .center)
            .foregroundColor(.clear)
            .position(center)
            .opacity(1-circleWidthheight/3000)
            .shadow(color: .white.opacity(0.8), radius: 5, x: 5, y:-5)
            .shadow(color: Color(red: 120 / 255, green: 20 / 255, blue: 20 / 255), radius: 5, x: -5, y:5)
            .blur(radius: circleWidthheight/30+3)
            .onAppear() {
                withAnimation(.linear(duration: 15).repeatForever()) {
                    circleWidthheight = 2000
                }
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainScreenView()
            .environmentObject(ViewModel())
    }
}
