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
    }
}

extension WebRepository.API: APICall {
    var header: [String : String] {
        return [
            "Content-Type": "application/json"
        ]
    }
    
    var path: String {
    }
    
    var method: HTTPMethod {
    }
}
