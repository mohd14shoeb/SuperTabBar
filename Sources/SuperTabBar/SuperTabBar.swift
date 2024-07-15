//
//  SuperTabBar.swift
//  Example
//
//  Created by Daniil Sentsov on 06/03/2024.
//

import SwiftUI

class TabSelection<Item: SuperTab>: ObservableObject {
    @Binding var selection: Item
    
    init(selection: Binding<Item>) {
        self._selection = selection
    }
}


public struct SuperTabBar<Item: SuperTab, Content: View>: View {
    
    private let selection: TabSelection<Item>
    private let content: Content
    @State private var items: [Item]
    
    init(selection: Binding<Item>,
         @ViewBuilder content: () -> Content) {
        self.selection = .init(selection: selection)
        self.content = content()
        self._items = .init(initialValue: .init())
    }
    
    private var tabItems: some View {
        HStack(spacing: 0) {
            ForEach(self.items, id: \.self) { item in
                if let customTabView = item.customTabView,
                   let customSelectedTabView = item.customSelectedTabView {
                    if self.selection.selection == item {
                        customSelectedTabView
                    } else {
                        customTabView
                            .onTapGesture {
                                self.selection.selection = item
                                self.selection.objectWillChange.send()
                            }
                    }
                } else {
                    VStack {
                        Image(self.selection.selection == item ? item.selectedIcon : item.icon)
                        Text(item.title)
                    }
                    .onTapGesture {
                        self.selection.selection = item
                        self.selection.objectWillChange.send()
                    }
                }
            }
            .frame(maxWidth: .infinity)
        }
    }
    
    public var body: some View {
        ZStack {
            self.content
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .environmentObject(self.selection)
            GeometryReader { geometry in
                VStack {
                    Spacer()
                    tabItems
                }
            }
        }
        .onPreferenceChange(TabBarPreferenceKey.self) { value in
            self.items = value
        }
    }
    
}
