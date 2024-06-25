//
//  ChargingView.swift
//  Tesla_SUI
//

import SwiftUI

/// Экран заряда батареи
struct ChargingView: View {
    
    enum Constant {
        static let fontVerdana = "Verdana"
        static let fontVerdanaBold = "Verdana-Bold"
        static let titleCharging = "CHARGING"
        static let titleProcent = "%"
        static let titleProcentSeventyFive = "75%"
        static let titleProcentHundred = "100%"
        static let titleSliderDrop = "sliderDrop"
        static let titleNearbySuperchargers = "Nearby Superchargers"
        static let titleMontreal = "Montreal, QC"
        static let titleFourAvailable = "2 / 4 available"
        static let titleKm = "1.7 km"
        static let titleMascouche = "Mascouche, QC"
        static let titleTwoAvailable = "2 / 2 available"
    }
    
    var body: some View {
        ZStack() {
            backgroundStackView {
                VStack {
                    HStack {
                        Spacer()
                        bacButtonView
                        Spacer()
                        chargingView
                        Spacer()
                        settingsButtonView
                        Spacer()
                    }
                    teslaImageView
                        .padding(.bottom, -60)
                        percentageView
                    sliderView
                        .padding(.bottom, 55)
                    limitsView
                        .padding(.bottom, -10)
                    ZStack {
                        withAnimation {
                            panelSuperchargersView
                        }
                        nearbyChargersView
                    }
                    Spacer()
                }
            }
        }
        .onAppear {
            opacityValue(1)
        }
        .onDisappear {
            opacityValue(0)
        }
    }
    
    @ObservedObject var viewModel = ChargingViewModel()
    @Environment(\.presentationMode) var presentation
    @State private var expandedList = false
    @State var opacityValue: (Int) -> ()
    
    private var gradient: LinearGradient {
        LinearGradient(colors: [Color.darkShadow.opacity(0.75), Color.gray.opacity(0.30)], startPoint: .topLeading, endPoint: .bottomTrailing)
    }
    
    private var darkBackground: LinearGradient {
        LinearGradient(colors: [.gray, .background, .black], startPoint: .topLeading, endPoint: .bottomTrailing)
    }
    
    private var bacButtonView: some View {
        Button(action: {
            presentation.wrappedValue.dismiss()
        }, label: {
            ZStack {
                RoundedRectangle(cornerRadius: 40.0)
                    .fill(darkBackground).opacity(0.60)
                    .frame(width: 44, height: 44)
                Image(.backArrow)
                    .tint(.gray)
            }
        })
        .background(RoundedRectangle(cornerRadius: 40)
            .fill(Color.background))
        .overlay(
            Circle()
                .stroke(gradient, lineWidth: 2)
        )
        .neumorphismSelectedBackCircleStyle()
    }
    
    private var chargingView: some View {
        Text(Constant.titleCharging)
            .font(.custom(Constant.fontVerdanaBold, size: 20))
            .foregroundColor(.white)
    }
    
    private var settingsButtonView: some View {
        Button(action: {
        }, label: {
            ZStack {
                RoundedRectangle(cornerRadius: 40)
                    .fill(darkBackground).opacity(0.60)
                    .frame(width: 44, height: 44)
                Image(.configure)
                    .tint(.gray)
            }
        })
        .background(RoundedRectangle(cornerRadius: 40)
            .fill(Color.background))
        .overlay(
            Circle()
                .stroke(gradient, lineWidth: 2)
        )
        .neumorphismSelectedBackCircleStyle()
    }
    
    private var teslaImageView: some View {
        Image(.teslaEnergy)
            .shadow(color: .white.opacity(0.5), radius: 20, x: 0, y: 0)
    }
    
    private var percentageView: some View {
        HStack {
            Text("\(viewModel.value)")
                .font(.custom(Constant.fontVerdanaBold, size: 32))
                .foregroundColor(.white)
                .animation(.easeInOut(duration: 0.3))
            Text(Constant.titleProcent)
                .font(.custom(Constant.fontVerdana, size: 20))
                .foregroundColor(.gray)
        }
    }
    
    private var limitsView: some View {
        HStack {
            Spacer()
                .frame(width: 155)
            VStack(alignment: .trailing) {
                Image(.interestRateCap)
                Text(Constant.titleProcentSeventyFive)
                    .foregroundColor(viewModel.value >= 75 ? .white : .gray)
            }
            .padding()
            VStack(alignment: .trailing) {
                Image(.interestRateCap)
                Text(Constant.titleProcentHundred)
                    .foregroundColor(viewModel.value >= 100 ? .white : .gray)
            }
        }
        .offset(y: -55)
        .font(.custom(Constant.fontVerdana, size: 15))
        .foregroundColor(.white)
    }
    
    private var sliderView: some View {
        VStack {
            CustomChargingSlider(value: $viewModel.value, offset: $viewModel.offset, colorTop: $viewModel.colorTop, colorBottom: $viewModel.colorBottom, imageCircle: Constant.titleSliderDrop)
                .padding(.horizontal, 65)
        }
    }
    
    private var panelSuperchargersView: some View {
        GeometryReader { geometry in
            HStack {
                Spacer()
                ZStack {
                    RoundedRectangle(cornerRadius: 25.0)
                        .fill(.clear)
                        .frame(width: 338, height: expandedList ? geometry.size.height : 130)
                        .overlay {
                            RoundedRectangle(cornerRadius: 25.0)
                                .stroke(.gray, lineWidth: 10)
                                .shadow(color: .black.opacity(0.8), radius: 6, x: 6, y: 6)
                                .shadow(color: .white.opacity(0.1), radius: 5, x: -5, y: -5)
                                .clipShape(RoundedRectangle(cornerRadius: 25.0).inset(by: 5.0))
                        }
                }
                Spacer()
            }
        }
    }
    
    private var nearbyChargersView: some View {
        VStack {
            HStack {
                Text(Constant.titleNearbySuperchargers)
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                Button(action: {
                    expandedList.toggle()
                }, label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 40)
                            .fill(darkBackground).opacity(0.60)
                            .frame(width: 44, height: 44)
                        Image(expandedList ? .arrowDown : .arrowUp)
                            .tint(.gray)
                    }
                })
                .background(RoundedRectangle(cornerRadius: 40)
                    .fill(Color.background))
                .overlay(
                    Circle()
                        .stroke(gradient, lineWidth: 2)
                )
                .neumorphismSelectedBackCircleStyle()
                
            }
            .offset(y: 40)
            Spacer()
            if expandedList {
                powerPlant
            }
        }
    }
    
    private var powerPlant: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text(Constant.titleMontreal)
                    Text(Constant.titleFourAvailable)
                }
                Spacer()
                VStack {
                    Image(.energyLocation)
                    Text(Constant.titleKm)
                }
            }
            HStack {
                VStack(alignment: .leading) {
                    Text(Constant.titleMascouche)
                    Text(Constant.titleTwoAvailable)
                }
                Spacer()
                VStack {
                    Image(.energyLocation)
                    Text(Constant.titleKm)
                }
            }
        }
        .padding(.horizontal, 60)
        .foregroundColor(.gray)
        .offset(y: -30)
        .padding(.vertical, 20)
    }
}

#Preview {
    ChargingView(opacityValue: { _ in
        
    })
        .environment(\.colorScheme, .dark)
}
