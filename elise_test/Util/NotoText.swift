//
//  NotoText.swift
//  elise_test
//
//  Created by Tabber on 2023/11/26.
//

import SwiftUI

struct NotoText: View {
    var text: String
    var color: Color = Colors.textBlack
    var size: CGFloat = 14
    var font: String = "NotoSansKR-Medium"
    var textAlignment: TextAlignment = .center
    
    var body: some View {
        Text(text)
            .foregroundColor(color)
            .font(.custom(font, size: size))
            .multilineTextAlignment(textAlignment)
    }
}
