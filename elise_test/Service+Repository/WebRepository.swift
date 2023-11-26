//
//  WebRepository.swift
//  elise_test
//
//  Created by Tabber on 2023/11/26.
//

import Alamofire
import Combine
import Foundation

protocol WebRepositoryProtocol {
    func getCourseList(offset: Int, count: Int, filterIsRecommend: Bool?, filterIsFree: Bool?, filterConditions: [String: Any]?) -> AnyPublisher<CourseListModel?, Error>
    
}

struct WebRepository: WebRepositoryProtocol {
    private var baseURL: String
    
    init(_ baseURL: String) {
        self.baseURL = baseURL
    }
    
    func getCourseList(offset: Int, count: Int, filterIsRecommend: Bool?, filterIsFree: Bool?, filterConditions: [String : Any]?) -> AnyPublisher<CourseListModel?, Error> {
        
        var parameter: [String: Any] = ["offset": offset,
                                        "count": count]
        
        if let filterIsRecommend = filterIsRecommend {
            parameter["filter_is_recommended"] = filterIsRecommend ? "true" : "false"
        }
        
        
        if let filterIsFree = filterIsFree {
            parameter["filter_is_free"] = filterIsFree ? "true" : "false"
        }
        
        if let filterConditions = filterConditions {
            parameter["filter_conditions"] = filterConditions
        }
        
        print("[@] parameter", parameter)
        
        let request: AnyPublisher<CourseListModel?, Error> = request(endpoint: API.getCourseList, parameters: parameter)
        
        return request.tryMap { obj -> CourseListModel? in
            return obj
        }
        .eraseToAnyPublisher()
    }
    
}

extension WebRepository {
    private func request<T: Decodable>(endpoint: APICall, decoder: JSONDecoder = JSONDecoder(),  parameters: [String: Any] = [:]) -> AnyPublisher<T?, Error> {
        
        let headers = HTTPHeaders(endpoint.header)
        
        let afRequest = AF.request(baseURL + endpoint.path, method: endpoint.method, parameters: parameters, encoding: URLEncoding.default, headers: headers)
        
        print("[@] URL:", afRequest.convertible.urlRequest?.url?.absoluteString ?? "")
        
        return afRequest.validate().publishData().tryMap { result -> T? in
            if let error = result.error {
                throw error
            }
            
            if let data = result.data {
                
                do {
                    let value = try decoder.decode(T.self, from: data)
                    return value
                } catch {
                    print(String(describing: error))
                    
                    return nil
                }
                
                
            } else {
                return nil
            }
            
        }
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
}
