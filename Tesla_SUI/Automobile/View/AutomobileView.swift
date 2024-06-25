//
//  AutomobileView.swift
//  Tesla_SUI
//

import SwiftUI

/// Экран автомобиля
struct AutomobileView: View {
    
    enum Constant {
        static let fontVerdana = "Verdana"
        static let fontVerdanaBold = "Verdana-Bold"
        static let titleTesla = "Tesla"
        static let titleKm = "178 km"
        static let titleOpenCar = "Закрыть"
        static let titleCloseCar = "Открыть"
        static let titleUnLock = "unLock"
        static let titleLock = "lock"
    }
    
    var body: some View {
        if #available(iOS 16.0, *) {
            NavigationStack {
                VStack {
                    backgroundStackView {
                        VStack {
                            headerView
                            carView
                            controlPanelView 
                            Spacer()
                                .frame(height: 40)
                            if tagSelected == 0 {
                                closeCarControlView
                            }
                            Spacer()
                                .frame(height: height)
                        }
                    }
                }
            }
        }
    }
    
    @ObservedObject var viewModel = AutomobileViewModel()
    @State private var isShowClimateView = false
    @State private var isCarClosed = false
    @State private var tagSelected = 0
    @State var opacityValue: (Int) -> ()
    
    
    private var height: CGFloat {
        tagSelected == 0 ? 160 : 252
    }
    
    private var gradient: LinearGradient {
        LinearGradient(colors: [Color.topGradient, Color.bottomGradient], startPoint: .bottom, endPoint: .top)
    }
    
    private var darkBackground: LinearGradient {
        LinearGradient(colors: [.gray, .background, .black], startPoint: .topLeading, endPoint: .bottomTrailing)
    }
    
    private var headerView: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(Constant.titleTesla)
                    .font(.system(size: 28))
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                Text(Constant.titleKm)
                    .font(.system(size: 18))
                    .fontWeight(.semibold)
                    .opacity(0.4)
            }
            Spacer()
        }
        .padding(.all, 25)
    }
    
    private var carView: some View {
        Image(isCarClosed ? .openCar : .closeCar)
            .resizable()
            .padding(.horizontal)
            .padding(.bottom, 40)
            .shadow(color: .white.opacity(0.6), radius: 15, x: 10, y: 10)
    }
    
    private var controlPanelView: some View {
        HStack(spacing: 30) {
            ForEach(viewModel.panelSettingsItems.indices, id: \.self) { index in
                if index == 1 {
                    NavigationLink(destination: ClimateView()) {
                        Image("\(viewModel.panelSettingsItems[index])")
                            .resizable()
                            .frame(width: 44, height: 44)
                            .neumorphismUnSelectedCircleStyle()
                            .overlay {
                                Circle()
                                    .stroke(gradient, lineWidth: 2)
                                    .opacity(tagSelected == index ? 1 : 0)
                            }
                    }
                } else {
                    Button(action: {
                        withAnimation {
                            tagSelected = index
                        }
                    }) {
                        Image("\(viewModel.panelSettingsItems[index])")
                            .resizable()
                            .frame(width: 44, height: 44)
                            .neumorphismUnSelectedCircleStyle()
                            .overlay {
                                Circle()
                                    .stroke(gradient, lineWidth: 2)
                                    .opacity(tagSelected == index ? 1 : 0)
                            }
                    }
                }
            }
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 50).fill(Color.background))
        .neumorphismUnSelectedStyle()
        .onAppear {
            opacityValue(1)
        }
        .onDisappear {
            opacityValue(0)
        }
    }
    
    private var closeCarControlView: some View {
        Button(action: {
            withAnimation {
                isCarClosed.toggle()
            }
        }, label: {
            HStack {
                Label {
                    Text(isCarClosed ? Constant.titleCloseCar : Constant.titleOpenCar)
                        .foregroundColor(.white)
                } icon: {
                    Image(isCarClosed ? Constant.titleUnLock : Constant.titleLock)
                        .renderingMode(.template)
                        .frame(width: 40, height: 40)
                        .neumorphismUnSelectedCircleStyle()
                }
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: 50).fill(Color.background))
            .neumorphismSelectedStyle()
        })
        .frame(width: 300)
    }
    
    private func settingsCustomTabBar() -> some View {
        ZStack {
            TabBarShape()
                .fill(darkBackground).opacity(1)
                .shadow(color: .topGradient, radius: 10)
                .opacity(0.3)
        }
    }
}

#Preview {
    AutomobileView(opacityValue: { _ in
        
    })
        .environment(\.colorScheme, .dark)
}
