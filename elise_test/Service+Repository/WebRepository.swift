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
}

struct WebRepository: WebRepositoryProtocol {
    private var baseURL: String
    
    init(_ baseURL: String) {
        self.baseURL = baseURL
    }
    
}

extension WebRepository {
    private func request<T: Decodable>(endpoint: APICall, decoder: JSONDecoder = JSONDecoder(),  parameters: [String: Any] = [:]) -> AnyPublisher<T?, Error> {
        
        let headers = HTTPHeaders(endpoint.header)
        
        let afRequest = AF.request(baseURL + endpoint.path, method: endpoint.method, parameters: parameters, encoding: URLEncoding.default, headers: headers)
        
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
