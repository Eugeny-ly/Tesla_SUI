//
//  ClimateViewModel.swift
//  Tesla_SUI
//

import SwiftUI

/// Вью Модель экрана настроек климата
final class ClimateViewModel: ObservableObject { 
    @Published var iconSettings = ["cold", "fan", "heat", "auto"]
    @Published var titleSettings = ["Ac", "Fan", "Heat", "Auto"]
    @Published var valueDegrees = [15, 15, 15, 15]
    @Published var changeValue = 0
    @Published var values = [0.0, 0.0, 0.0, 0.0]
    @Published var tagSegmented = 0 
} 
