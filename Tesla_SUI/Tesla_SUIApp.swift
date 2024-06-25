//
//  Tesla_SUIApp.swift
//  Tesla_SUI
//

import SwiftUI

@main
struct Tesla_SUIApp: App {
    var body: some Scene {
        WindowGroup {
            TeslaLogoView()
                .environment(\.colorScheme, .dark)
        }
    }
}
