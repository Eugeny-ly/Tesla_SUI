//
//  AutomobileViewModel.swift
//  Tesla_SUI
//

import Foundation

/// Вью модель экрана автомобиля
final class AutomobileViewModel: ObservableObject {
    @Published var panelSettingsItems = ["lockUnLock", "fanIcon", "hood", "chagings"]
}
