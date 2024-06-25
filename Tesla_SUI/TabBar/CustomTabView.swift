//
//  CustomTabView.swift
//  Tesla_SUI
//

import SwiftUI

/// Кастомный таб бар
struct TabItemPreferenceKey: PreferenceKey {
    static var defaultValue: [TabItem] = []
    
    static func reduce(value: inout [TabItem], nextValue: () -> [TabItem]) {
        value += nextValue() 
    }
}


struct TabBarModifire: ViewModifier {
    var tabBarItem: TabItem
    
    func body(content: Content) -> some View {
        content
            .preference(key: TabItemPreferenceKey.self, value: [tabBarItem])
    }
}

struct TabItem: Identifiable, Equatable {
    var id = UUID()
    var icon: String
}

struct CustomTabView<Content: View>: View {
    
    @Binding var selection: Int
    @Binding var opacity: Int
    @Namespace private var tabBarItem
    
    @State private var tabBarItems : [TabItem] = [.init(icon: "car.rear.fill"), .init(icon: "bolt.fill"), .init(icon: "mappin.and.ellipse"), .init(icon: "person.fill")]
    
    private var content: Content
    
    init(selection: Binding<Int>, @ViewBuilder content: () -> Content, opacity: Binding<Int>) {
        _selection = selection
        self.content = content()
        _opacity = opacity
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            content
                    HStack {
                        tabsView
                    }
                    .padding(.vertical, 5)
                    .ignoresSafeArea()
                    .background(
                        TabBarShape()
                            .fill(LinearGradient(colors: [.gray, .background, .black], startPoint: .topLeading, endPoint: .bottomTrailing))
                            .ignoresSafeArea()
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .overlay(content: {
                                TabBarShape()
                                    .stroke(LinearGradient(colors: [.gray, .black], startPoint: .top, endPoint: .bottom), lineWidth: 1)
                                    .ignoresSafeArea()
                                TabBarShape()
                                    .stroke(LinearGradient(colors: [.white.opacity(0.4), .black], startPoint: .top, endPoint: .bottom), lineWidth: 2)
                                    .shadow(radius: 10, y: -1)
                                    .ignoresSafeArea()
                            })
                    )
                    .opacity(Double((opacity)))
            }
            .onPreferenceChange(TabItemPreferenceKey.self, perform: { value in
                self.tabBarItems = value
            })
        }
    
    private var tabsView: some View {
        ForEach(Array(tabBarItems.enumerated()), id: \.offset) { index, element in
            Spacer()
            Image(systemName: element.icon)
                .foregroundColor(selection == index ? .topGradient : .gray)
                .offset(y: 10)
                .background(
                    ZStack {
                        if selection == index {
                            Circle()
                                .fill(.topGradient.opacity(0.4))
                                .shadow(color: .green.opacity(0.7), radius: 20)
                                .offset(y: 10)
                                .blur(radius: 10)
                                .frame(width: 50, height: 50)
                                .matchedGeometryEffect(id: "tabBar", in: tabBarItem)
                        }
                    }
                )
                .onTapGesture {
                    withAnimation {
                        selection = index
                    }
                }
            Spacer()
        }
    }
}
