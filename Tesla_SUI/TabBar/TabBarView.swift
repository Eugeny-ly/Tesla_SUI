//
//  TabBarView.swift
//  Tesla_SUI
//

import SwiftUI

/// Экран таб бара
struct TabBarView : View {
    @State private var tabBarSelection = 0
    @State private var opacity = 1

    var body: some View {
        CustomTabView(selection: $tabBarSelection, content: {
            AutomobileView(opacityValue: { value in
                opacity = value
            })
                    .myTabItem {
                        TabItem(icon: "car.rear.fill")
                    }
                    .opacity(tabBarSelection == 0 ? 1 : 0)

            ChargingView(opacityValue: { value in
                opacity = value
            })
                    .myTabItem {
                        TabItem(icon: "bolt.fill")
                    }
                    .opacity(tabBarSelection == 1 ? 1 : 0)
                
            Color.background
                    .myTabItem {
                        TabItem(icon: "mappin.and.ellipse")
                    }
                    .opacity(tabBarSelection == 2 ? 1 : 0)
            
            Color.background
                    .myTabItem {
                        TabItem(icon: "person.fill")
                    }
                    .opacity(tabBarSelection == 3 ? 1 : 0)
            }, opacity: $opacity)
    }
}

extension View {
    func myTabItem(_ label: () -> TabItem) -> some View {
        modifier(TabBarModifire(tabBarItem: label()))
    }
}

#Preview {
    TabBarView()
        .preferredColorScheme(.dark)
}
