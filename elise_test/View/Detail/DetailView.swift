//
//  DetailView.swift
//  elise_test
//
//  Created by Tabber on 2023/11/26.
//

import SwiftUI

struct DetailView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var viewModel: ViewModel
    
    var body: some View {
        VStack {
            
            toolBar
            
            ScrollView {
                Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            }
            
            Spacer()
        }
        .navigationBarBackButtonHidden()
    }
    
    var toolBar: some View {
        HStack(spacing: 0) {
            Button(action: {
                close()
            }, label: {
                Image("ic_arrow_back_left")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
            })
            
            Spacer()
            
        }
        .padding(.horizontal, 16)
    }
    
    func close() {
        presentationMode.wrappedValue.dismiss()
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(viewModel: .init(service: Service(webRepository: .init("https://api-rest.elice.io/org/academy/"))))
    }
}
