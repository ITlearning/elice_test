//
//  DetailViewModel.swift
//  elise_test
//
//  Created by Tabber on 2023/11/26.
//

import Foundation
import Combine

extension DetailView {
    class ViewModel: ObservableObject {
        var service: Service
        
        init(service: Service) {
            self.service = service
        }
    }
}
