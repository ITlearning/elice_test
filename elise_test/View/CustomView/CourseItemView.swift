//
//  CourseItemView.swift
//  elise_test
//
//  Created by Tabber on 2023/11/26.
//

import SwiftUI
import SDWebImageSwiftUI

struct CourseItemView: View {
    
    var item: Course
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            
            Group {
                if let imageUrl = item.imageFileURL {
                    WebImage(url: URL(string: imageUrl))
                        .resizable()
                        .indicator(.activity(style: .medium))
                        .scaledToFit()
                        .cornerRadius(10)
                        .clipped()
                    
                } else if let logoUrl = item.logoFileURL {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(Colors.titleImageBackgroundGray)
                        .overlay(
                            WebImage(url: URL(string: logoUrl))
                                .resizable()
                                .indicator(.activity(style: .medium))
                                .scaledToFit()
                                .frame(width: 56, height: 56)
                        )
                } else {
                    Image("titleImageNotFound")
                }
            }
            .frame(width: 200, height: 100)
            
            NotoText(text: item.title, size: 14, font: .notoSansBold, textAlignment: .leading)
                .lineLimit(2)
                .padding(.top, 8)
            
            if !item.shortDescription.isEmpty {
                NotoText(text: item.shortDescription, size: 10, font: .notoSansLight, textAlignment: .leading)
                    .padding(.top, 2)
                    .lineLimit(2)
            }
            
            if let tags = item.tags, !tags.isEmpty {
                FlexibleView(
                    data: tags.map({ $0.name }),
                    spacing: 4,
                    alignment: .leading
                  ) { item in
                      NotoText(text: item, size: 8, font: .notoSansBold)
                          .padding(.vertical, 2)
                          .padding(.horizontal, 4)
                      .background(
                        RoundedRectangle(cornerRadius: 4)
                            .fill(Colors.tagsGray)
                       )
                      .frame(height: 16)
                  }
                  .padding(.top, 8)
            }
            
            
            Spacer()
        }
        .frame(width: 200, height: 220)
    }
}
