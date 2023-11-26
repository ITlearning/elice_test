//
//  APICall.swift
//  elise_test
//
//  Created by Tabber on 2023/11/26.
//

import Foundation
import Alamofire

protocol APICall {
    var header: [String: String] { get }
    var path: String { get }
    var method: HTTPMethod { get }
}

extension WebRepository {
    public enum API {
    case getCourseList
    case getCourseItem
    case getLectureList
    }
}

extension WebRepository.API: APICall {
    var header: [String : String] {
        return [
            "Content-Type": "application/json"
        ]
    }
    
    var path: String {
        switch self {
        case .getCourseList:
            return "course/list/"
        case .getCourseItem:
            return "course/get/"
        case .getLectureList:
            return "lecture/list/"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getCourseList, .getCourseItem, .getLectureList:
            return .get
        }
    }
}
