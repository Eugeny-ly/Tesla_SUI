//
//  CustomTabBar.swift
//  Tesla_SUI
//

import SwiftUI

/// Форма кастомного таббара
struct TabBarShape: Shape {
    func path(in rect: CGRect) -> Path {
        Path { path in
            let midX = rect.midX
            let midY = rect.midY
            let maxX = rect.maxX
            
            path.move(to: CGPoint(x: midX - 7, y: midY - 4))
            path.addQuadCurve(to: CGPoint(x: midX + 32, y: midY - 23), control: CGPoint(x: midX + 10, y: midY))
            path.addQuadCurve(to: CGPoint(x: midX + 100, y: midY - 40), control: CGPoint(x: midX + 50, y: midY - 40))
            path.addLine(to: CGPoint(x: maxX - 40, y: midY - 40))
            path.addQuadCurve(to: CGPoint(x: maxX, y: midY - 10), control: CGPoint(x: maxX - 20, y: midY - 40))
            path.addQuadCurve(to: CGPoint(x: maxX - 40, y: midY + 40), control: CGPoint(x: maxX, y: midY + 40))
            path.addLine(to: CGPoint(x: midX, y: midY + 40))
            path.addLine(to: CGPoint(x: 40, y: midY + 40))
            path.addQuadCurve(to: CGPoint(x: 0, y: midY - 10), control: CGPoint(x: 0, y: midY + 40))
            path.addQuadCurve(to: CGPoint(x: 40, y: midY - 40), control: CGPoint(x: 20, y: midY - 40))
            path.addLine(to: CGPoint(x: midX - 100, y: midY - 40))
            path.addQuadCurve(to: CGPoint(x: midX - 35, y: midY - 19), control: CGPoint(x: midX - 50, y: midY - 40))
            path.addQuadCurve(to: CGPoint(x: midX - 5, y: midY - 4), control: CGPoint(x: midX - 12, y: midY))
        }
    }
}
