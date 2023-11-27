//
//  CouseItemModel.swift
//  elise_test
//
//  Created by Tabber on 2023/11/27.
//

import Foundation

// MARK: - CourseItemModel
struct CourseItemModel: Codable {
    let result: ResultModel
    let course: Course?

    enum CodingKeys: String, CodingKey {
        case result = "_result"
        case course
    }
}
