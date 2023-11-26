//
//  elise_testApp.swift
//  elise_test
//
//  Created by Tabber on 2023/11/26.
//

import SwiftUI

@main
struct elise_testApp: App {
    
    var service = Service(webRepository: .init("https://api-rest.elice.io/org/academy/"))
    
    var body: some Scene {
        WindowGroup {
            MainView(viewModel: .init(service: service))
        }
    }
}
