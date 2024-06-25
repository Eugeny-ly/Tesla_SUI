//
//  ContentView.swift
//  Tesla_SUI
//

import SwiftUI

/// Приветственный экран
struct ContentView: View {
    
    enum Constant {
        static let fontVerdana = "Verdana"
        static let fontVerdanaBold = "Verdana-Bold"
        static let titleUnlock = "unLock"
        static let titleLock = "lock"
        static let titleHi = "Hi, Yevgeny"
        static let titleWelcomeBack = "Welcome back"
    }
    
    var body: some View {
        if #available(iOS 16.0, *) {
            NavigationStack {
                backgroundStackView {
                    VStack {
                            HStack {
                                Spacer()
                                settingsButton
                            }
                        .offset(x: -20)
                        Spacer()
                        greetingTextView
                        imageTeslaView
                        Spacer()
                            closeOpenCarView
                        Spacer()
                            .frame(height: 70)
                    } 
                }
            }
        }
    }
    
    @State private var isShowAutomobileView = false
    @State private var isLockUnlockCar = false
    @State private var isSettingsButtonEnabled = false

    @State private var tagSelected = 0
    
    private var gradient: LinearGradient {
        LinearGradient(colors: [Color.buttonStrokeDark, Color.buttonStrokeLight], startPoint: .top, endPoint: .bottom)
    }
    
    private var darkBackground: LinearGradient {
        LinearGradient(colors: [.gray, .background, .black], startPoint: .topLeading, endPoint: .bottomTrailing)
    }
    
    private var settingsButton: some View {
        VStack {
            Button(action: {
                withAnimation {
                    isShowAutomobileView.toggle()
                }
            }, label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 40)
                        .fill(darkBackground).opacity(0.60)
                        .frame(width: 44, height: 44)
                    Image(.configure)
                        .tint(.gray)
                }
            })
            .background(RoundedRectangle(cornerRadius: 50).fill(Color.background))
            .frame(width: 100)
            .overlay(
                Circle()
                    .stroke(gradient, lineWidth: 2)
            )
            .neumorphismSelectedBackCircleStyle()
            .disabled(!isSettingsButtonEnabled)
        }
        .fullScreenCover(isPresented: $isShowAutomobileView) {
            TabBarView()
        }
    }
    
    private var closeOpenCarView: some View {
        Button(action: {
            withAnimation {
                isLockUnlockCar.toggle()
                isSettingsButtonEnabled = isLockUnlockCar
            }
        }, label: {
            HStack {
                Text(isLockUnlockCar ? Constant.titleUnlock : Constant.titleLock)
                    .foregroundColor(.white)
                    .font(Font.system(size: 16))
                    .padding()
                    ZStack {
                        RoundedRectangle(cornerRadius: 40)
                            .fill(darkBackground).opacity(0.60)
                            .frame(width: 44, height: 44)
                        Image(isLockUnlockCar ? Constant.titleUnlock : Constant.titleLock)
                            .tint(.gray)
                    }
                    .overlay {
                        Circle()
                            .stroke(gradient, lineWidth: 2)
                    }
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 40)
                    .fill(.clear)
                    .frame(width: 170, height: 80)
                    .overlay(
                        RoundedRectangle(cornerRadius: 40)
                            .stroke(.gray, lineWidth: 10)
                            .shadow(color: .black.opacity(0.8), radius: 6, x: 6, y: 6)
                            .shadow(color: .white.opacity(0.1), radius: 5, x: -5, y: -5)
                            .clipShape(RoundedRectangle(cornerRadius: 40).inset(by: 5.0))
                    )
            )
            .neumorphismSelectedStyle()
        })
    }
    
    private var imageTeslaView: some View {
        VStack {
            if isLockUnlockCar {
                Image(.teslaThisAfternoon)
            } else {
                Image(.teslaInTheNight)
            }
        }
    }
    
    private var greetingTextView: some View {
        VStack {
            if isLockUnlockCar {
                Text(Constant.titleHi)
                    .font(.custom(Constant.fontVerdana, size: 20))
                    .foregroundColor(.gray)
                Text(Constant.titleWelcomeBack)
                    .font(.custom(Constant.fontVerdanaBold, size: 30))
            }
        }
    }
    
    func backgroundStackView<Content: View>(content: () -> Content) -> some View {
        ZStack {
            Rectangle()
                .fill(isLockUnlockCar ? LinearGradient(colors: [Color.backgrounWelcomingTopL, Color.backgrounWelcomingMiddleL, Color.backgrounWelcomingBottomL], startPoint: .top, endPoint: .bottom) :  LinearGradient(colors: [Color.backgrounWelcomingTopN, Color.backgrounWelcomingMiddleN, Color.backgrounWelcomingBottomN], startPoint: .top, endPoint: .bottom))
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .edgesIgnoringSafeArea(.all)
            content()
        } 
    }
}

#Preview {
    ContentView()
        .environment(\.colorScheme, .dark)
}
