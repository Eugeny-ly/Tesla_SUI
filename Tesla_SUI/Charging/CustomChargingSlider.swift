//
//  CustomChargingSlider.swift
//  Tesla_SUI
//

import SwiftUI

/// Кастомный слайдер и панель батареи
struct CustomChargingSlider: View {
    
    enum Constant {
        static let titleSetChargeLimit = "Set Charge Limit"
    }
    
    @Binding var offset: Double
    @Binding var colorTop: Color
    @Binding var colorBottom: Color
    @State var imageCircle: String
    @State var progressRectangle: CGFloat = 0.65
    @State var offsetRectangle: CGFloat = 0
    var sets: Double = 0
    var offsetRec: Double {
        return Double(value) * 2.75
    }
    
    var body: some View {
        GeometryReader { reader in
            let maxSliderWidth = reader.size.width - 16
            VStack {
                VStack {
                    ZStack(alignment: .leading) {
                        CustomChargingShape()
                            .fill(LinearGradient(colors: [.white.opacity(0.2), .black.opacity(0.1), .white.opacity(0.2)], startPoint: .top, endPoint: .bottom))
                            .frame(width: 274,height: 48)
                        
                        CustomChargingShape()
                            .fill(LinearGradient(gradient: Gradient(colors: [Color.battaryTopOn, Color.battaryBottomOn]), startPoint: .top, endPoint: .bottom))
                            .frame(maxWidth: 275, maxHeight: 48)
                            .mask(
                                GeometryReader { geometry in
                                    CustomChargingShape()
                                        .frame(width: geometry.size.width * progressRectangle, height: geometry.size.height)
                                        .overlay {
                                            CustomChargingShape()
                                                .blur(radius: 11)
                                        }
                                }
                            )
                        
                    }
                    .padding(.bottom, 40)
                    ZStack(alignment: .leading) {
                        RoundedRectangle(cornerRadius: 25)
                            .fill(
                                LinearGradient(gradient: Gradient(colors: [.black, .white.opacity(0.1)]), startPoint: .top, endPoint: .bottom)
                            )
                            .frame(height: 10)
                        RoundedRectangle(cornerRadius: 25)
                            .fill(
                                LinearGradient(gradient: Gradient(colors: [colorTop, colorBottom]), startPoint: .top, endPoint: .bottom)
                            )
                            .frame(width: offset, height: 10)
                        Image(imageCircle)
                            .frame(width: 10)
                            .offset(x: offset, y: 5)
                            .gesture(
                                DragGesture(minimumDistance: 0)
                                    .onChanged({ dragValue in
                                        var translation = dragValue.translation.width + lastOffset
                                        translation = min(max(translation, 0), maxSliderWidth)
                                        let dragPercent = getDragPercent(translation: translation, of: maxSliderWidth)
                                        let valueNum = dragPercentToValue(dragPercent: dragPercent)
                                        value = valueNum
                                        offset = valueToFillPercent(valueNum) * maxSliderWidth
                                        progressRectangle = offset / maxSliderWidth
                                    })
                                
                                    .onEnded({ _ in
                                        lastOffset = offset
                                    })
                            )
                    }
                    .frame(height: 16)
                }
                Text(Constant.titleSetChargeLimit)
                    .opacity(0.4)
                    .padding(.top, 5)
            }
        }
        .frame(maxHeight: 30)
    }
    
    private let step = 1
    @Binding private var value: Int
    @State private var lastOffset = 0.0
    @State private var previousValue = 15
    private var minValue = 0
    private var maxValue = 100
    
    init(
        value: Binding<Int>,
        offset: Binding<Double>,
        colorTop: Binding<Color>,
        colorBottom: Binding<Color>,
        imageCircle: String
    ) {
        _value = value
        _offset = offset
        _colorTop = colorTop
        _colorBottom = colorBottom
        self.imageCircle = imageCircle
    }
    
    private func getDragPercent(translation: CGFloat, of maxWidth: CGFloat) -> CGFloat {
        translation / maxWidth
    }
    
    private func dragPercentToValue(dragPercent: CGFloat) -> Int {
        let actualValue = Int(dragPercent * Double(maxValue - minValue) + Double(minValue))
        let remainder = actualValue % step
        var roundedValue = actualValue
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            if remainder < step / 2 {
                roundedValue = actualValue - remainder
            } else {
                roundedValue = actualValue - remainder + step
            }
        }
        return Int(roundedValue)
    }
    
    private func valueToFillPercent(_ result: Int) -> CGFloat {
        Double(result - minValue) / Double((maxValue - minValue))
    }
}
