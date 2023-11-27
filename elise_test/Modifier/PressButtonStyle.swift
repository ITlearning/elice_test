//
//  PressButtonStyle.swift
//  elise_test
//
//  Created by Tabber on 2023/11/27.
//

import SwiftUI

struct PressButtonStyle: ButtonStyle {
    
    var effectSize: CGFloat = 0.95
    
    init(effectSize: CGFloat = 0.95) {
        self.effectSize = effectSize
    }
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? effectSize : 1)
            .animation(.easeInOut(duration: 0.1), value: configuration.isPressed)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .foregroundColor(Color.black.opacity(configuration.isPressed ? 0.1 : 0.0))
                    .scaleEffect(configuration.isPressed ? effectSize : 1)
                    .animation(.easeInOut(duration: 0.1), value: configuration.isPressed)
            )
            .contentShape(RoundedRectangle(cornerRadius: 8))
    }
}

