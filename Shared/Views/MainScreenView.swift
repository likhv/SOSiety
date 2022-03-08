//
//  ContentView.swift
//  Shared
//
//  Created by Vladislav Likh on 07/02/22.
//

import SwiftUI
import Alamofire
import SystemConfiguration
import Contacts

struct MainScreenView: View {
    @EnvironmentObject var viewModel: SOSViewModel
    @State var isInfoPresenting = true
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
                    Color.white.ignoresSafeArea()
                }
                if viewModel.isSOS && !isFAQOpened {
                    LoopedWaveAnimationView(center: CGPoint(x: UIScreen.main.bounds.width-20.0-20.0-25.0, y: UIScreen.main.bounds.height/2 + 28.0))
                        .ignoresSafeArea()
                    
                } else if viewModel.isSOS {
                    LoopedWaveAnimationView(center: CGPoint(x: UIScreen.main.bounds.width-20.0-20.0-25.0, y: UIScreen.main.bounds.height/2 + 28.0+tumblerOffset))
                        .ignoresSafeArea()
                    
                }
                if viewModel.isSOS {
                    if viewModel.statusConsole.count == 0 {
                        TimerView().offset(y: 80+tumblerOffset)
                    } else {
                        StatusConsole().offset(y: 80+tumblerOffset)
                    }
                }
                TumblerView(isSOS: $viewModel.isSOS, isFAQOpened: $isFAQOpened)
                    .offset(y: tumblerOffset)
                
                HeaderView(headerText: viewModel.isSOS ? "SOS mode\nlaunched" : "Everything\nis ready")
                    .opacity(headerOpacity)
                    .offset(y: tumblerOffset/4)
                AdviceTabView(isFAQPresenting: $isFAQOpened)
                    .opacity(1-headerOpacity)
                    .offset(y: (UIScreen.main.bounds.height/1.77 + tumblerOffset) * 1.5)
                VStack {
                    Spacer()
                    Button { toggleFAQ() } label: {
                        VStack {
                            HStack {
                                Text(isFAQOpened ? "Close advice" : "Legal advice")
                                    .font(.system(size: 18, weight: .medium))
                                    .padding(.bottom, 5)
                                Image(systemName: "multiply")
                                    .font(.system(size: 18, weight: .medium))
                                    .padding(.bottom, 4)
                                    .opacity(isFAQOpened ? 1 : 0)
                            }
                            Image(systemName: "chevron.down")
                                .font(.system(size: 18, weight: .medium))
                                .opacity(isFAQOpened ? 0 : 1)
                        }
                    }
                }
                .offset(y: tumblerOffset/1.55)
                if viewModel.firstScreenPresented {
                    FirstStartView(firstScreenPresented: $viewModel.firstScreenPresented)
                }
            }
            .onAppear {
                viewModel.checkIfLocationServicesIsEnabled()
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
                    if !viewModel.firstScreenPresented {
                        Button {isInfoPresenting = true} label: {
                            Image(systemName: "info.circle")
                                .font(.system(size: 16, weight: .bold))
                                .foregroundColor(.black)
                        }
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    if !viewModel.firstScreenPresented {
                        NavigationLink(destination: SettingsView(), label: {
                            Image(systemName: "person.crop.circle.badge.plus")
                                .font(.system(size: 16, weight: .bold))
                                .foregroundColor(.black)
                        })
                    }
                }
            }
            .accentColor(.black)
            .fullScreenCover(isPresented: $isInfoPresenting) {
                InformationView(isInfoPresenting: $isInfoPresenting)
            }
            //            .fullScreenCover(isPresented: $firstScreenPresented) {
            //                FirstStartView(firstScreenPresented: $firstScreenPresented)
            //            }
        }
    }
    var swipeUp: some Gesture {
        DragGesture(coordinateSpace: .global)
            .onChanged { value in
                if value.translation.height < -100 && !isFAQOpened {
                    toggleFAQ()
                } else if value.translation.height > 100 && isFAQOpened {
                    toggleFAQ()
                }
            }
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

struct StatusConsole: View {
    @EnvironmentObject var viewModel: SOSViewModel
    var body: some View {
        VStack {
            ForEach(viewModel.statusConsole, id: \.self) {status in
                Text(status)
            }
        }
    }
}

struct AdviceTabView: View {
    @EnvironmentObject var viewModel: SOSViewModel
    @Binding var isFAQPresenting: Bool
    
    var body: some View {
        ZStack {
            VStack {
                Divider()
                TabView {
                    if Locale.preferredLanguages[0].prefix(2) == "ru" {
                        ForEach(0..<viewModel.ruAdviceList.count) { n in
                            AdviceItemView(number: n+1, adviceAmount: viewModel.ruAdviceList.count, text: viewModel.ruAdviceList[n].text)
                        }
                    } else if Locale.preferredLanguages[0].prefix(2) == "fr" {
                        ForEach(0..<viewModel.frAdviceList.count) { n in
                            AdviceItemView(number: n+1, adviceAmount: viewModel.frAdviceList.count, text: viewModel.frAdviceList[n].text)
                        }
                    } else {
                        ForEach(0..<viewModel.enAdviceList.count) { n in
                            AdviceItemView(number: n+1, adviceAmount: viewModel.enAdviceList.count, text: viewModel.enAdviceList[n].text)
                        }
                    }
                    
                }
                .padding(.bottom, 30)
                .statusBar(hidden: true)
                .tabViewStyle(.page(indexDisplayMode: .always))
            }
        }
        .frame(width: UIScreen.main.bounds.width, height:  230)
        .ignoresSafeArea()
        .onAppear() {
            UIPageControl.appearance().pageIndicatorTintColor = .black.withAlphaComponent(0.2)
            UIPageControl.appearance().currentPageIndicatorTintColor = .black
        }
    }
}

struct AdviceItemView: View {
    var number = 1
    var adviceAmount = 12
    var title = "Try not to sign any papers"
    var text = "If you aren’t sure about documents officers ask you to sign, try not to do that. It is also important with empty blanks"
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 1) {
                //                Text(adviceTitle)
                //                    .font(.system(size: 26, weight: .bold))
                //                    .foregroundColor(.black)
                //                    .padding(.bottom, 14)
                Text("\(number)/\(adviceAmount)")
                    .font(.system(size: 18, weight: .medium))
                    .foregroundColor(.black)
                    .multilineTextAlignment(.leading)
                    .padding(.top, 20)
                Text(text)
                    .font(.system(size: 18, weight: .medium))
                    .foregroundColor(.black)
                    .multilineTextAlignment(.leading)
                    .padding(.top, 20)
                Spacer()
                
            }
            .padding(.horizontal, 30)
            Spacer()
        }
        
    }
}

struct TumblerView: View {
    @EnvironmentObject var viewModel: SOSViewModel
    @EnvironmentObject var contactsViewModel: ContactsViewModel
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
                        if Locale.preferredLanguages[0].prefix(2) == "ru" {
                            Text(isSOS ? "Смахни влево, чтобы его выключить" : "Смахни вправо, чтобы включить режим SOS")
                                .font(.system(size: 18, weight: .regular))
                                .foregroundColor(.sosietyPaper.opacity(0.8))
                                .padding(!isSOS ? .leading : .trailing, 10)
                                .animation(.easeInOut, value: isSOS)
                                .multilineTextAlignment(.center)
                                .opacity(textOpacity)
                        } else if Locale.preferredLanguages[0].prefix(2) == "fr" {
                            Text(isSOS ? "Swipe vers la gauche pour le désactiver" : "Swipe vers la droite pour activer le mode SOS")
                                .font(.system(size: 18, weight: .regular))
                                .foregroundColor(.sosietyPaper.opacity(0.8))
                                .padding(!isSOS ? .leading : .trailing, 10)
                                .animation(.easeInOut, value: isSOS)
                                .multilineTextAlignment(.center)
                                .opacity(textOpacity)
                        } else {
                            Text(isSOS ? "Swipe left to turn it off" : "Swipe right to activate the SOS mode")
                                .font(.system(size: 18, weight: .regular))
                                .foregroundColor(.sosietyPaper.opacity(0.8))
                                .padding(!isSOS ? .leading : .trailing, 10)
                                .animation(.easeInOut, value: isSOS)
                                .multilineTextAlignment(.center)
                                .opacity(textOpacity)
                        }
                        
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
                            .simultaneousGesture(dragSOS)
                    })
                .padding(.horizontal, 20)
            //                .ignoresSafeArea()
        }
    }
    var dragSOS: some Gesture {
        
        DragGesture(coordinateSpace: .global)
            .onChanged { value in
                withAnimation(.linear){
                    textOpacity = 0.0
                }
                
                withAnimation(.linear){
                    if value.translation.width + swipeDistance > UIScreen.main.bounds.width - 40 - 10 - circleDiameter {
                        swipeDistanceDelta = UIScreen.main.bounds.width - 40 - 10 - circleDiameter - swipeDistance
                        
                    } else if value.translation.width + swipeDistance < 5.0 {
                        swipeDistanceDelta = -swipeDistance
                        
                    } else {
                        swipeDistanceDelta = value.translation.width
                    }
                }
            }
            .onEnded { value in
                let leftPosition = UIScreen.main.bounds.width - 40 - 10 - circleDiameter
                let rightPosition = 0.0
                
                withAnimation(.linear){
                    textOpacity = 1.0
                }
                withAnimation(.linear){
                    if viewModel.isSOS {
                        if swipeDistanceDelta + swipeDistance < rightPosition + 50 {
                            swipeDistance = rightPosition
                            viewModel.stopSOS()
                            drawHaptic.impactOccurred()
                        }
                    } else {
                        if swipeDistanceDelta + swipeDistance > leftPosition - 50 {
                            swipeDistance = leftPosition
                            viewModel.isSOS = true
                            drawHaptic.impactOccurred()
                        }
                    }
                    swipeDistanceDelta = .zero
                }
            }
    }
}

struct TimerView: View{
    @State private var timeRemaining = 5
    @EnvironmentObject var viewModel: SOSViewModel
    @EnvironmentObject var contactsViewModel: ContactsViewModel
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    var body: some View {
        Text("Sending in \(timeString(time: timeRemaining))")
            .onReceive(timer) { time in
                if self.timeRemaining > 0 {
                    self.timeRemaining -= 1
                }else{
                    self.timer.upstream.connect().cancel()
                    viewModel.startSOS(to: contactsViewModel.addedContacts)
                }
            }
    }
    
    func timeString(time: Int) -> String {
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format:"%02i:%02i", minutes, seconds)
    }
}

struct HeaderView: View {
    //    var isSOS: Bool
    var headerText: String
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
        .onReceive(wavesTimer) { input in
            if counted % 4 == 0 {
                circlesArray.append(AnimatedCircle(center:center))
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
            .stroke(style: StrokeStyle(lineWidth: 0.8))
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
            .environmentObject(SOSViewModel())
            .environmentObject(InformationScreenViewModel())
            .environmentObject(ContactsViewModel())
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView()
    }
}
