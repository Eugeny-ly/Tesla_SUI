//
//  TeslaLogoView.swift
//  Tesla_SUI
//

import SwiftUI

struct TeslaLogoView: View {
    @State var isActivateLPresentLogo = false
    @State var drawingValue: CGFloat = 0.0
    
    var body: some View {
            ZStack {
                if isActivateLPresentLogo {
                    ContentView()
                        .transition(.opacity.animation(.easeInOut(duration: 3)))
                } else {
                    backgroundStackView {
                        TeslaLogo()
                            .fill(LinearGradient(colors: [.gray, .background, .black], startPoint: .topLeading, endPoint: .bottomTrailing))
                            .frame(width: 300, height: 400)
                            .overlay {
                                TeslaLogo()
                                    .trim(from: 0, to: drawingValue)
                                    .stroke(LinearGradient(gradient: Gradient(colors: [Color(uiColor: .systemRed), Color(uiColor: .black)]), startPoint: .topLeading, endPoint: .topTrailing), style: StrokeStyle(lineWidth: 3, lineCap: .square))
                                    .frame(width: 300, height: 400)
                                    .animation(.easeIn(duration: 3.0), value: drawingValue)
                                    .onAppear {
                                        self.drawingValue = 1.0
                                    }
                            }
                    }
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: {
                            withAnimation(.linear(duration: 2)) {
                                isActivateLPresentLogo = true
                            }
                        })
                    }
                }
            }
        }
    
    private var darkBackground: LinearGradient {
        LinearGradient(colors: [.gray, .background, .black], startPoint: .topLeading, endPoint: .bottomTrailing)
    }
}

#Preview {
    TeslaLogoView()
        .environment(\.colorScheme, .dark)
}
