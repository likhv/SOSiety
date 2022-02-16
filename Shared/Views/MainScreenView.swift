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
    let drawHaptic = UIImpactFeedbackGenerator(style: .heavy)
    var body: some View {
        NavigationView {
            ZStack {
                if viewModel.isSOS {
                    Color.sosietyRed.ignoresSafeArea()
                } else {
                    Color.sosietyPaper.ignoresSafeArea()
                }
                if viewModel.isSOS {
                    WavesAnimationView(center: CGPoint(x: UIScreen.main.bounds.width-20.0-20.0-25.0, y: UIScreen.main.bounds.height/2 + 28.0))
                        .offset(y: tumblerOffset)
                        .ignoresSafeArea()
                }
                TumblerView(isSOS: $viewModel.isSOS, isFAQOpened: $isFAQOpened)
                    .offset(y: tumblerOffset)
                HeaderView(isSOS: viewModel.isSOS)
                    .opacity(headerOpacity)
                    .offset(y: tumblerOffset/4)
                AdviceTabView(isFAQPresenting: $isFAQOpened)
                    .opacity(1-headerOpacity)
                    .offset(y: (UIScreen.main.bounds.height/1.9 + tumblerOffset) * 1.5)
                VStack {
                    Spacer()
                    Button { toggleFAQ() } label: {
                        VStack {
                            HStack {
                                Text(isFAQOpened ? "Close advice" : "Legal advice")
                                    .font(.system(size: 18, weight: .semibold))
                                    .padding(.bottom, 5)
                                Image(systemName: isFAQOpened ? "multiply" : "")
                                    .font(.system(size: 18, weight: .semibold))
                                    .padding(.bottom, 4)
                            }
                            .opacity(isFAQOpened ? 0 : 1)
                            Image(systemName: "chevron.down")
                                .font(.system(size: 18, weight: .semibold))
                                .opacity(isFAQOpened ? 0 : 1)
                        }
                    }
                }

            }
            .gesture(swipeUp)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("#SOSiety")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.black)
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {isInfoPresenting = true} label: {
                        Image(systemName: "info.circle")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(.black)
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: SettingsView(), label: {
                        Image(systemName: "gearshape")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(.black)
                    })
               }
            }
//            .navigationBarItems(
//                leading:
//                    Button {isInfoPresenting = true} label: {
//                        Image(systemName: "info.circle")},
//                trailing:
//                    NavigationLink(destination: SettingsView(), label: {
//                        Image(systemName: "gearshape")
//                    }))
            .accentColor(.black)
            .fullScreenCover(isPresented: $isInfoPresenting) {
                InformationView(isInfoPresenting: $isInfoPresenting)
            }
        }
    }
    var swipeUp: some Gesture {
        DragGesture(coordinateSpace: .global)
            .onEnded { value in
                if value.translation.height < -100 && !isFAQOpened {
                    toggleFAQ()
                } else if value.translation.height > 100 && isFAQOpened {
                    toggleFAQ()
                }
            }
    }
    func toggleFAQ() {
        withAnimation(.spring()) {
            if isFAQOpened {
                isFAQOpened = false
                tumblerOffset = 0
                headerOpacity = 1.0
                drawHaptic.impactOccurred()
            } else {
                isFAQOpened = true
                tumblerOffset -= UIScreen.main.bounds.height/3
                headerOpacity = 0.0
                drawHaptic.impactOccurred()
            }
//            FAQHeight = UIScreen.main.bounds.height - 250.0
        }
    }
    
}

struct AdviceTabView: View {
    @EnvironmentObject var viewModel: ViewModel
    @Binding var isFAQPresenting: Bool

    var body: some View {
        TabView {
                AdviceItemView()
                AdviceItemView()
                AdviceItemView()
                AdviceItemView()
        }
        .statusBar(hidden: true)
        .frame(width: UIScreen.main.bounds.width, height:  240)
        .tabViewStyle(.page)
        .onAppear() {
            UIPageControl.appearance().pageIndicatorTintColor = .gray
            UIPageControl.appearance().currentPageIndicatorTintColor = .black
        }
//        .indexViewStyle(.page(backgroundDisplayMode: .never))
    }
}

struct AdviceItemView: View {
    var adviceTitle = "Try not to sign any papers"
    var adviceText = "1/12\n\nIf you aren’t sure about documents officers ask you to sign, try not to do that. It is also important with empty blanks"
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
//                Text(adviceTitle)
//                    .font(.system(size: 26, weight: .bold))
//                    .foregroundColor(.black)
//                    .padding(.bottom, 14)
                Text(adviceText)
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.black)
            }
            .padding(30)
            Spacer()
        }
        
    }
}

struct AdviceItemViewOld: View {
    @EnvironmentObject var viewModel: ViewModel
    var adviceTitle = "Try not to sign any papers"
    var adviceText = "If you aren’t sure about documents officers ask you to sign, try not to do that. It is also important with empty blanks"
    var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: 10, style: .circular)
                .frame(width: UIScreen.main.bounds.width-42, height: UIScreen.main.bounds.width-42, alignment: .center)
                .foregroundColor(.white)
//                .shadow(color: .black, radius: 15, x: 0, y: 15)
                .overlay(
                    HStack {
                        VStack(alignment: .leading) {
                            Text(adviceTitle)
                                .font(.system(size: 26, weight: .bold))
                                .foregroundColor(.black)
                                .padding(.bottom, 14)
                            Text(adviceText)
                                .font(.system(size: 18, weight: .medium))
                                .foregroundColor(.black)
                            Spacer()
                        }
                        .padding(30)
                        .padding(.trailing, 10)
                        Spacer()
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
//                .ignoresSafeArea()
        }
    }
    var drag: some Gesture {
        DragGesture(coordinateSpace: .global)
            .onChanged { value in
                withAnimation(){
                    
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
                withAnimation(){
                    textOpacity = 1.0
                }
                withAnimation(){
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
                    .foregroundColor(.black)
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
    let wavesTimer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State var counted = 0
    var body: some View {
        ZStack {
            ForEach(circlesArray, id: \.id) { circle in
                circle
            }
            .onChange(of: circlesArray.count) { array in
                if array > 5 { circlesArray.remove(at: 0)}
                print(circlesArray.count)
            }
        }
//        .onAppear() {
//            if circlesArray.count == 0 {
//                circlesArray.append(AnimatedCircle(center:center))
//            }
//        }
        .onReceive(wavesTimer) { input in
            if counted % 4 == 0 {
                circlesArray.append(AnimatedCircle(center:center))
                DispatchQueue.main.asyncAfter(deadline: .now()) {
                    drawHaptic.impactOccurred()
                }
            }
            counted += 1
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
            .foregroundColor(.sosietyPaper.opacity(0.75))
            .position(center)
            .opacity(1.0-(circleWidthheight/1000))
            .onAppear() {
                withAnimation(.linear(duration: 30).repeatForever()) {
                    circleWidthheight = 2000
                }
            }
            .ignoresSafeArea()
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
