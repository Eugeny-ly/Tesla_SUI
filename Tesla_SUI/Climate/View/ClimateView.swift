//
//  ClimateView.swift
//  Tesla_SUI
//

import SwiftUI

struct ClimateView: View {
    
    enum Constant {
        static let fontVerdana = "Verdana"
        static let fontVerdanaBold = "Verdana-Bold"
        static let titleNeedHelp = "Need help?"
        static let titleLinkSupportTesla = "https://www.tesla.com/support"
        static let titleSupport = "Tesla Support"
        static let titleClose = "сlose"
        static let titleClimateControl = "Climate control"
        static let titleConditionerON = "A/C is ON"
        static let titleLocationCharging = "Tap to turn off or swipe up\n for a fast setip"
        static let titleOn = "On"
        static let titleVent = "Vent"
        static let titleClimate = "CLIMATE"
        static let titlepictureDropSlider = "dropSlider"
    }
    
    var body: some View {
        if #available(iOS 16.0, *) {
            ZStack {
                backgroundStackView {
                    ZStack {
                        VStack {
                            ZStack {
                                degressView
                                    .padding(.bottom, 15)
                                mainValueTemperatureView
                                    .padding(.bottom, 15)
                                circleAnimationView
                                
                            }
                            climateControlView
                            Spacer()
                                .frame(height: 50)
                        }
                        .padding()
                        VStack {
                            pullLeverView
                            buttonAirStart
                                .padding(.bottom, 15)
                            HStack {
                                colorSettingsView
                                    .padding(.trailing, 60)
                                airTemperatureStepperView
                                    .padding(.trailing, 65)
                                windowLifterView
                                    .padding(.trailing, 30)
                            }
                            .padding(.bottom, 20)
                            windowLiftersInfoView
                            Spacer()
                        }
                        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height + 350)
                        .background(RoundedRectangle(cornerRadius: 30).fill(Color(.backgroundConfigClimate)))
                        .ignoresSafeArea(.all, edges: .bottom)
                        .offset(y: UIScreen.main.bounds.height)
                        .offset(y: currentMenuOffSetY)
                        .gesture(dragGesture)
                    }
                }
                if isShowAllertSettings {
                    settingAlertView
                        .transition(.opacity)
                        .zIndex(1.0)
                }
            }
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: backBarButtonView, trailing: settingsBarButtonView)
            .toolbar {
                customTitleToolbar()
            }
        }
    }
    
    @ObservedObject var climateViewModel = ClimateViewModel()
    @GestureState private var gestureOffSet = CGSize.zero
    @State private var isExpanded = true
    @State private var isTappedButtonAirStart = false
    @State private var showBlur = false
    @State private var isStepperOn = false
    @State private var isShowAllertSettings = false
    @State private var currentMenuOffSetY: CGFloat = 0.0
    @State private var lastMenuOffSetY: CGFloat = 0.0
    @State private var progress = 0.0
    @State private var selectedColor = Color.blue
    @State private var linkURL: URL?
    @Environment(\.presentationMode) var presentation
    
    private var gradient: LinearGradient {
        LinearGradient(colors: [Color.darkShadow.opacity(0.75), Color.gray.opacity(0.30)], startPoint: .topLeading, endPoint: .bottomTrailing)
    }
    
    private var gradientAirStart: LinearGradient {
        LinearGradient(colors: [Color.trimAirStartTop, Color.trimAirStartBottom], startPoint: .topLeading, endPoint: .bottomTrailing)
    }
    
    private var darkBackground: LinearGradient {
        LinearGradient(colors: [.gray, .background, .black], startPoint: .topLeading, endPoint: .bottomTrailing)
    }
    
    private var backBarButtonView: some View {
        Button(action: {
            presentation.wrappedValue.dismiss()
        }, label: {
            ZStack {
                RoundedRectangle(cornerRadius: 40)
                    .fill(darkBackground).opacity(0.60)
                    .frame(width: 44, height: 44)
                    .offset(x: 7)
                Image(.backArrow)
                    .tint(.gray)
                    .offset(x: 7)
            }
            Spacer()
        })
        .background(RoundedRectangle(cornerRadius: 40).fill(Color.background))
        .overlay(
            Circle()
                .stroke(gradient, lineWidth: 2)
        )
        .neumorphismSelectedBackCircleStyle()
    } 
    
    private var settingsBarButtonView: some View {
        Button(action: {
            isShowAllertSettings = true
        }, label: {
            ZStack {
                RoundedRectangle(cornerRadius: 40)
                    .fill(darkBackground).opacity(0.60)
                    .frame(width: 44, height: 44)
                Image(.configure)
                    .tint(.gray)
            }
            Spacer()
        })
        .background(RoundedRectangle(cornerRadius: 40).fill(Color.background))
        .overlay {
            Circle()
                .stroke(gradient, lineWidth: 2)
        }
        .neumorphismSelectedBackCircleStyle()
    }
    
    private var settingAlertView: some View {
            VStack {
                Text(Constant.titleNeedHelp)
                    .font(.custom(Constant.fontVerdanaBold, size: 18))
                    .foregroundColor(.white)
                    .padding(.bottom, 10)
                Spacer()
                    .frame(height: 20)
                let url = URL(string: Constant.titleLinkSupportTesla)
                Link(Constant.titleSupport, destination: url ?? URL(fileURLWithPath: ""))
                Spacer()
                Button(action: {
                    withAnimation {
                        isShowAllertSettings.toggle()
                    }
                }, label: {
                    Text(Constant.titleClose)
                        .foregroundColor(.white)
                })
                .foregroundColor(.white)
                .font(.custom(Constant.fontVerdana, size: 14))
        }
            .frame(width: 150, height: 100)
            .padding(35)
            .background(RoundedRectangle(cornerRadius: 30)
                .fill(LinearGradient(gradient: Gradient(colors: [Color.backgrounWelcomingTopN, Color.backgrounWelcomingBottomN]), startPoint: .topLeading, endPoint: .bottomTrailing)))
            .overlay(
                Rectangle()
                    .stroke(gradient, lineWidth: 5)
                    .cornerRadius(35)
            )
    }
    
    private var degressView: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 85)
                .fill(LinearGradient(colors: [.black.opacity(0.5), .background, .gray.opacity(0.6)], startPoint: .topLeading, endPoint: .bottomTrailing))
                .frame(width: 170, height: 170)
                .background(RoundedRectangle(cornerRadius: 85).fill(Color.background))
                .neumorphismSelectedBackCircleStyle()
            
            RoundedRectangle(cornerRadius: 60)
                .fill(LinearGradient(colors: [.gray.opacity(0.5), .background, .black.opacity(0.6)], startPoint: .topLeading, endPoint: .bottomTrailing))
                .frame(width: 120, height: 120)
                .shadow(color: .gray.opacity(0.15), radius: 25, x: -5, y: -5)
                .shadow(color: .black.opacity(0.75), radius: 15, x: 6, y: 6)
        }
    }
    
    private var circleAnimationView: some View {
        Circle()
            .trim(from: 0, to: CGFloat(climateViewModel.valueDegrees[climateViewModel.tagSegmented] - 15) / 15)
            .stroke(LinearGradient(gradient: Gradient(colors: [selectedColor]), startPoint: .leading, endPoint: .trailing), style:  StrokeStyle(lineWidth: 20, lineCap: .round))
            .offset(x: 7)
            .frame(height: 145)
            .rotationEffect(.degrees(-90))
            .shadow(color: selectedColor, radius: 10)
            .animation(.easeInOut(duration: 1.0))
    }
    
    private var mainValueTemperatureView: some View {
        VStack {
            if isTappedButtonAirStart {
                Text("\(climateViewModel.valueDegrees[climateViewModel.tagSegmented])°C")
                    .font(.custom(Constant.fontVerdanaBold, size: 30))
                    .foregroundColor(.gray)
            }
        }
    }
    
    private var climateControlView: some View {
        DisclosureGroup(isExpanded: $isExpanded) {
            ForEach(climateViewModel.iconSettings.indices, id: \.self) { index in
                makeClimateContolSettings(index: index, title: climateViewModel.titleSettings[index], icon: climateViewModel.iconSettings[index], value: $climateViewModel.valueDegrees[index])
            }
        } label: {
            Text(Constant.titleClimateControl)
                .font(.custom(Constant.fontVerdana, size: 20))
                .padding()
                .foregroundStyle(.gray)
        }
        
    }
    
    private var dragGesture: some Gesture {
        DragGesture()
            .updating($gestureOffSet) { value, state, transaction in
                state = value.translation
                onChangeClimateMenuOffSet()
            }
            .onEnded { value in
                let menuHeight = UIScreen.main.bounds.height - 700
                withAnimation {
                    let newMenuOffsetY = currentMenuOffSetY + value.translation.height
                    let maxUpwardOffset = -menuHeight
                    if currentMenuOffSetY == 0 && value.translation.height > 0 { return }
                    if newMenuOffsetY < maxUpwardOffset {
                        currentMenuOffSetY = maxUpwardOffset
                    } else if newMenuOffsetY > 0 {
                        currentMenuOffSetY = 0
                    } else {
                        currentMenuOffSetY = newMenuOffsetY
                    } 
                    lastMenuOffSetY = currentMenuOffSetY
                }
            }
    }
    
    private var pullLeverView: some View {
        Capsule()
            .fill(.black)
            .frame(width: 80, height: 3)
            .padding(.top)
    }
    
    private var buttonAirStart: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(Constant.titleConditionerON)
                    .font(.custom(Constant.fontVerdanaBold, size: 20))
                    .foregroundColor(.white)
                    .padding(.bottom, 5)
                Text(Constant.titleLocationCharging)
                    .font(.custom("Verdana", size: 16))
                    .foregroundColor(.gray)
            }
            Spacer()
            Button(action: {
                isTappedButtonAirStart.toggle()
            }, label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 40)
                        .fill(.topGradient).opacity(0.60)
                        .frame(width: 44, height: 44)
                    Image(.onOff)
                        .frame(width: 24, height: 24)
                        .padding(.all, 30)
                        .overlay {
                            Circle()
                                .stroke(gradientAirStart, lineWidth: 3)
                        }
                        .neumorphismSelectedAirStartkCircleStyle()
                }
            })
            .background(RoundedRectangle(cornerRadius: 40).fill(Color.topGradient))
            .overlay(
                Circle()
                    .stroke(gradientAirStart, lineWidth: 1)
            )
            .neumorphismSelectedAirStartkCircleStyle()
        }
        .padding()
    }
    
    private var colorSettingsView: some View {
        ColorPicker("", selection: $selectedColor)
            .accentColor(.black)
    }
    
    private var airTemperatureStepperView: some View {
        HStack {
            Button(action: {
                guard climateViewModel.valueDegrees[climateViewModel.tagSegmented] > 15 else { return }
                climateViewModel.values[climateViewModel.tagSegmented] -= 10
                climateViewModel.valueDegrees[climateViewModel.tagSegmented] -= 1
            }) {
                Image(.arrowLeft)
            }
            .frame(width: 30)
            Text("\(climateViewModel.valueDegrees[climateViewModel.tagSegmented])°")
                .font(.custom(Constant.fontVerdanaBold, size: 35))
                .foregroundColor(.white)
                .frame(width: 80)
            Button(action: {
                guard climateViewModel.valueDegrees[climateViewModel.tagSegmented] < 30 else { return }
                climateViewModel.values[climateViewModel.tagSegmented] += 10
                climateViewModel.valueDegrees[climateViewModel.tagSegmented] += 1
            }) {
                Image(.arrowRight)
            }
            .frame(width: 25)
        }
        .disabled(!isTappedButtonAirStart)
    }
    
    private var windowLifterView: some View {
        Image(.windowLifter)
    }
    
    private var windowLiftersInfoView: some View {
        HStack {
            Text(Constant.titleOn)
            Spacer()
            Text(Constant.titleVent)
        }
        .padding(.horizontal, 25)
        .font(.custom(Constant.fontVerdana, size: 16))
        .foregroundColor(.gray)
    }
    
    private func onChangeClimateMenuOffSet() {
        DispatchQueue.main.async {
            currentMenuOffSetY = gestureOffSet.height
        }
    }
    
    private func customTitleToolbar() -> some ToolbarContent {
        ToolbarItem(placement: .principal) {
            Text(Constant.titleClimate)
                .font(.custom(Constant.fontVerdanaBold, size: 20))
                .foregroundColor(.white)
        }
    }

    private func makeClimateContolSettings(index: Int, title: String, icon: String, value: Binding<Int>) -> some View {
        HStack {
            Text(title)
                .font(.custom(Constant.fontVerdana, size: 22))
                .foregroundStyle(.gray)
                .frame(width: 60)
                .padding()
            Button(action: {
                climateViewModel.tagSegmented = index
            }, label: {
                if climateViewModel.tagSegmented == index {
                    ZStack {
                        RoundedRectangle(cornerRadius: 40)
                            .fill(.topGradient).opacity(0.55)
                            .frame(width: 44, height: 44)
                        Image(icon)
                            .accentColor(.white)
                            .overlay {
                                Circle()
                                    .stroke(gradientAirStart, lineWidth: 1)
                            }
                            .neumorphismSelectedAirStartkCircleStyle()
                    }
                    .background(RoundedRectangle(cornerRadius: 40).fill(Color.background))
                    .overlay {
                        Circle()
                            .stroke(darkBackground, lineWidth: 2)
                    }
                    .neumorphismSelectedBackCircleStyle()
                } else {
                    ZStack {
                        RoundedRectangle(cornerRadius: 40)
                            .fill(darkBackground).opacity(0.55)
                            .frame(width: 44, height: 44)
                        Image(icon)
                            .accentColor(.gray)
                            .overlay {
                                Circle()
                                    .stroke(darkBackground, lineWidth: 1)
                            }
                            .neumorphismSelectedBackCircleStyle()
                    }
                    .background(RoundedRectangle(cornerRadius: 40).fill(Color.background))
                    .overlay {
                        Circle()
                            .stroke(darkBackground, lineWidth: 2)
                    }
                    .neumorphismSelectedBackCircleStyle()
                }
            })
            Spacer()
                .frame(width: 40)
                if isStepperOn {
                    SliderView(value: $climateViewModel.valueDegrees[index], minimumValue: 15, maximumValue: 30, changeValue: $climateViewModel.changeValue, progress: $climateViewModel.values[index], offSet: $climateViewModel.values[index], color: selectedColor, image: Constant.titlepictureDropSlider)
                } else {
                    SliderView(value: $climateViewModel.valueDegrees[index], minimumValue: 15, maximumValue: 30, changeValue: $climateViewModel.changeValue, progress: $climateViewModel.values[index], offSet: $climateViewModel.values[index], color: selectedColor, image: Constant.titlepictureDropSlider)
                        .disabled(!isTappedButtonAirStart)
                }
        }
        .tint(.white)
        .frame(width: 350, height: 65)
    }
}

#Preview {
    ClimateView()
        .environment(\.colorScheme, .dark)
}

