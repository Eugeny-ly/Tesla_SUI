//
//  NeumorphismViewModifier.swift
//  Tesla_SUI
//

import SwiftUI

/// Конструкторы теней
struct NeumorphismUnSelected: ViewModifier {
    func body(content: Content) -> some View {
        content
            .shadow(color: Color(.lightShadow), radius: 5, x: -5, y: -5)
            .shadow(color: Color(.darkShadow), radius: 5, x: 5, y: 5)
    }
}

struct NeumorphismSelected: ViewModifier {
    func body(content: Content) -> some View {
        content
            .shadow(color: Color(.lightShadow), radius: 5, x: 5, y: 5)
            .shadow(color: Color(.darkShadow), radius: 5, x: -5, y: -5)
    }
}

struct NeumorphismUnSelectedCircle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(.all, 10)
            .background(Circle().fill(Color(.background)))
            .neumorphismUnSelectedStyle()
    }
}

struct NeumorphismUnConfigureCircle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .shadow(color: Color(.lightShadow), radius: 5, x: -5, y: -5)
            .shadow(color: Color(.darkShadow), radius: 5, x: 5, y: 5)
    }
}

struct NeumorphismSelectedBackCircle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(Circle().fill(Color.background))
            .shadow(color: .gray.opacity(0.10), radius: 7, x: -5, y: -5)
            .shadow(color: .black.opacity(0.75), radius: 15, x: 6, y: 6)
    }
}

struct NeumorphismSelectedAirStartkCircle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(Circle().fill(Color.topGradient))
            .shadow(color: .gray.opacity(0.15), radius: 5, x: -5, y: -5)
            .shadow(color: .black, radius: 10, x: 5, y: 5)
    }
}

//MARK: - Extension + View

extension View {
    func neumorphismUnSelectedStyle() -> some View {
        modifier(NeumorphismUnSelected())
    }
    
    func neumorphismSelectedStyle() -> some View {
        modifier(NeumorphismSelected())
    }
    
    func neumorphismUnSelectedCircleStyle() -> some View {
        modifier(NeumorphismUnSelectedCircle())
    }
    
    func neumorphismSelectedBackCircleStyle() -> some View {
        modifier(NeumorphismSelectedBackCircle())
    }
    
    func neumorphismSelectedAirStartkCircleStyle() -> some View {
        modifier(NeumorphismSelectedAirStartkCircle())
    }
}
