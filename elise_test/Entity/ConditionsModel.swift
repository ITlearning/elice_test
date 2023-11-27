//
//  ConditionsModel.swift
//  elise_test
//
//  Created by Tabber on 2023/11/28.
//

import Foundation

struct ConditionsModel: Codable {
    var courseId: [Int]
    
    enum CodingKeys: String, CodingKey {
        case courseId = "course_id"
    }
}


