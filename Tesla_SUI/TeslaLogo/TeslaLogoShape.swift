//
//  TeslaLogoShape.swift
//  Tesla_SUI
//

import SwiftUI

struct TeslaLogo: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        
        path.move(to: CGPoint(x: 0.5 * width, y: 0.22347 * height))
        
        path.addLine(to: CGPoint(x: 0.60319 * width, y: 0.09734 * height))
        
        path.addCurve(to: CGPoint(x: 0.95606 * width, y: 0.18297 * height),
                      control1: CGPoint(x: 0.60319 * width, y: 0.09734 * height),
                      control2: CGPoint(x: 0.77994 * width, y: 0.10109 * height))
        
        path.addCurve(to: CGPoint(x: 0.82147 * width, y: 0.28453 * height),
                      control1: CGPoint(x: 0.91097 * width, y: 0.25116 * height),
                      control2: CGPoint(x: 0.82147 * width, y: 0.28453 * height))
        
        path.addCurve(to: CGPoint(x: 0.64 * width, y: 0.21 * height),
                      control1: CGPoint(x: 0.81544 * width, y: 0.22462 * height),
                      control2: CGPoint(x: 0.77347 * width, y: 0.21 * height))
        
        path.addLine(to: CGPoint(x: 0.50003 * width, y: 1.00003 * height))
         
        path.addLine(to: CGPoint(x: 0.35909 * width, y: 0.20984 * height))
        
        path.addCurve(to: CGPoint(x: 0.17859 * width, y: 0.28437 * height),
                      control1: CGPoint(x: 0.22659 * width, y: 0.20984 * height),
                      control2: CGPoint(x: 0.18462 * width, y: 0.2245 * height))
        
        path.addCurve(to: CGPoint(x: 0.044 * width, y: 0.18313 * height),
                      control1: CGPoint(x: 0.17859 * width, y: 0.28437 * height),
                      control2: CGPoint(x: 0.08906 * width, y: 0.25134 * height))
        
        path.addCurve(to: CGPoint(x: 0.39687 * width, y: 0.0975 * height),
                      control1: CGPoint(x: 0.22009 * width, y: 0.10125 * height),
                      control2: CGPoint(x: 0.39687 * width, y: 0.0975 * height))
        
        path.addLine(to: CGPoint(x: 0.50006 * width, y: 0.22347 * height))
        
        path.addLine(to: CGPoint(x: 0.49991 * width, y: 0.22347 * height))
        
        path.addLine(to: CGPoint(x: 0.5 * width, y: 0.22347 * height))
        
        path.closeSubpath()
        
        path.move(to: CGPoint(x: 0.5 * width, y: 0.06103 * height))
        
        path.addCurve(to: CGPoint(x: 0.972 * width, y: 0.15591 * height),
                      control1: CGPoint(x: 0.64225 * width, y: 0.05972 * height),
                      control2: CGPoint(x: 0.80519 * width, y: 0.083 * height))
        
        path.addCurve(to: CGPoint(x: width, y: 0.09781 * height),
                      control1: CGPoint(x: 0.99431 * width, y: 0.11553 * height),
                      control2: CGPoint(x: width, y: 0.09781 * height))
        
        path.addCurve(to: CGPoint(x: 0.5 * width, y: 0),
                      control1: CGPoint(x: 0.81772 * width, y: 0.02553 * height),
                      control2: CGPoint(x: 0.64697 * width, y: 0.00066 * height))
        
        path.addCurve(to: CGPoint(x: 0, y: 0.09781 * height),
                      control1: CGPoint(x: 0.35303 * width, y: 0.00066 * height),
                      control2: CGPoint(x: 0.18228 * width, y: 0.02541 * height))
        
        path.addCurve(to: CGPoint(x: 0.028 * width, y: 0.15609 * height),
                      control1: CGPoint(x: 0, y: 0.09781 * height),
                      control2: CGPoint(x: 0.00813 * width, y: 0.11978 * height))
        
        path.addCurve(to: CGPoint(x: 0.5 * width, y: 0.06088 * height),
                      control1: CGPoint(x: 0.19484 * width, y: 0.08284 * height),
                      control2: CGPoint(x: 0.35775 * width, y: 0.05975 * height))
        
        path.addLine(to: CGPoint(x: 0.5 * width, y: 0.06103 * height))
        
        path.closeSubpath()
        return path
    }
}
