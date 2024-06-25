//
//  ChargingViewModel.swift
//  Tesla_SUI
//

import SwiftUI

/// Вью модель экрана зарядки
final class ChargingViewModel: ObservableObject {
    @Published var value = 0
    @Published var offset = 0.0
    @Published var colorTop = Color.battaryTopOn
    @Published var colorBottom = Color.battaryBottomOn
}
