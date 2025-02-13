//
//  ActiveButtonTabBarStyle.swift
//  Example
//
//  Created by Daniil Sentsov on 19/07/2024.
//

import SwiftUI
import SuperTabBar

struct ActiveButtonTabBarStyle: TabBarStyle {
    
    var onButtonClicked: () -> Void
    
    public func tabBar(with geometry: GeometryProxy, itemsView: @escaping () -> AnyView) -> some View {
        VStack(spacing: 0.0) {
            Button {
                onButtonClicked()
            } label: {
                ZStack {
                    Circle()
                        .fill(.indigo)
                        .frame(width: 52, height: 52)
                    Image("camera")
                        .foregroundColor(.white)
                }
            }
            .padding(.bottom, -26)
            ZStack {
                backgroundShape
                    .foregroundColor(Color.indigo)
                itemsView()
            }
            .padding(.bottom, geometry.safeAreaInsets.bottom)
            .frame(height: 70 + geometry.safeAreaInsets.bottom)
        }
    }
    
    var backgroundShape: some View {
        Path { path in
            path.move(to: CGPoint(x: 0, y: 0))
            
            let startCurveX: CGFloat = 40 + 6
            let endXOffset: CGFloat = 25 + 6
            let endYOffset: CGFloat = 8
            let curveX: CGFloat = 28 + 6
            
            path.addLine(to: CGPoint(x: UIScreen.main.bounds.size.width / 2 - startCurveX, y: 0))
            
            path.addCurve(to: CGPoint(x: UIScreen.main.bounds.size.width / 2 - endXOffset, y: endYOffset),
                          control1: CGPoint(x: UIScreen.main.bounds.size.width / 2 - startCurveX, y: 0),
                          control2: CGPoint(x: UIScreen.main.bounds.size.width / 2 - curveX, y: 0))
            
            path.addArc(center: CGPoint(x: UIScreen.main.bounds.size.width / 2, y: 0),
                        radius: 26 + 6,
                        startAngle: .degrees(160 - 15),
                        endAngle: .degrees(20 + 15),
                        clockwise: true)
            
            path.addCurve(to: CGPoint(x: UIScreen.main.bounds.size.width / 2 + startCurveX, y: 0),
                          control1: CGPoint(x: UIScreen.main.bounds.size.width / 2 + endXOffset, y: endYOffset),
                          control2: CGPoint(x: UIScreen.main.bounds.size.width / 2 + curveX, y: 0))
            
            path.addLine(to: CGPoint(x: UIScreen.main.bounds.size.width, y: 0))
            path.addLine(to: CGPoint(x: UIScreen.main.bounds.size.width, y: 200))
            path.addLine(to: CGPoint(x: 0, y: 200))
            path.addLine(to: CGPoint(x: 0, y: 0))
        }.shadow(color: Color(UIColor.black.withAlphaComponent(0.1)), radius: 8)
    }
    
}
