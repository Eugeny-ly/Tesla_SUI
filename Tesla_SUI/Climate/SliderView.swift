//
//  SliderView.swift
//  Tesla_SUI
//

import SwiftUI

/// Кастомный слайдер
struct SliderView: View {
    var color: Color
    var image: String
    
    var body: some View {
        GeometryReader { reader in
            let maxSliderWidth = reader.size.width - 16
            VStack(alignment: .leading) { 
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 25)
                        .fill(
                            LinearGradient(gradient: Gradient(colors: [.black, .white.opacity(0.4)]), startPoint: .top, endPoint: .bottom)
                        )
                        .frame(height: 10)
                    RoundedRectangle(cornerRadius: 25)
                        .fill(
                            LinearGradient(gradient: Gradient(colors: [color]), startPoint: .top, endPoint: .bottom)
                        )
                        .frame(width: offSet, height: 10)
                    Image(image)
                        .frame(width: 10)
                        .offset(x: offSet, y: 1.5)
                        .gesture(
                            DragGesture(minimumDistance: 0)
                                .onChanged({ dragValue in
                                    var translation = dragValue.translation.width + lastOffSet
                                    translation = min(max(translation, 0), maxSliderWidth)
                                    let dragPercent = getDragPercent(translation: translation, of: maxSliderWidth)
                                        let valueNum = dragPercentToValue(dragPercent: dragPercent)
                                        value = valueNum
                                    offSet = valueToFillPercent(valueNum) * maxSliderWidth
                                })
                                    
                                .onEnded({ _ in
                                    lastOffSet = offSet
                                })
                        )
                }
                .frame(height: 16)
            }
        }
        .frame(maxHeight: 30)
    }
    
    private let minimumValue: Int
    private let maximumValue: Int
    @Binding private var value: Int
    @Binding var changeValue: Int
    @Binding var offSet: Double
    @Binding var progress: Double
    @State private var lastOffSet = 0.0
    
    private var step = 1
    
    init(value: Binding<Int>, minimumValue: Int, maximumValue: Int, changeValue: Binding<Int>, progress: Binding<Double>, offSet: Binding<Double>, color: Color, image: String) {
        self.minimumValue = minimumValue
        self.maximumValue = maximumValue
        self.color = color
        self.image = image
        _value = value
        _changeValue = changeValue
        _progress = progress
        _offSet = offSet
    }
    
    private func getDragPercent(translation: CGFloat, of maxWidth: CGFloat) -> CGFloat {
        translation / maxWidth
    }
    
    private func dragPercentToValue(dragPercent: CGFloat) -> Int {
        let actualValue = Int(dragPercent * Double(maximumValue - minimumValue) + Double(minimumValue))
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
        Double(result - minimumValue) / Double((maximumValue - minimumValue))
    }
}
