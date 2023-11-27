//
//  DetailView.swift
//  elise_test
//
//  Created by Tabber on 2023/11/26.
//

import SwiftUI
import Parma
import Kingfisher

struct DetailView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var viewModel: ViewModel
    
    @State var imageInit: Bool = false
    
    let safeArea = UIApplication
        .shared
        .connectedScenes
        .flatMap { ($0 as? UIWindowScene)?.windows ?? [] }
        .last { $0.isKeyWindow }?.safeAreaInsets
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            
            toolBar
            ZStack {
                ScrollView {
                    
                    if let imageUrl = viewModel.course?.imageFileURL {
                        
                        let logoUrl = viewModel.course?.logoFileURL
                        let title = viewModel.course?.title
                        
                        imageInitTitle(imageUrl, logoUrl ?? "", title ?? "")
                    } else if let logoUrl = viewModel.course?.logoFileURL {
                        
                        let title = viewModel.course?.title
                        let shortDescrpition = viewModel.course?.shortDescription
                        
                        notImageInitTitle(title ?? "", shortDescrpition: shortDescrpition ?? "", logoUrl: logoUrl)
                    }
                     
                    Spacer()
                        .frame(height: 16)
                    

                    
                    if let description = viewModel.course?.description {
                        
                        HStack {
                            NotoText(text: "과목 소개", color: Colors.lecturePurple, size: 14, font: .notoSansBold)
                            Spacer()
                        }
                        .padding(.horizontal, 16)
                        
                        Rectangle()
                            .foregroundColor(Colors.lineGray)
                            .frame(height: 1)
                            .padding(.horizontal, 16)
                        
                        descriptionView(description)
                            .padding(.top, 10)
                    }
                    
                    HStack {
                        NotoText(text: "커리큘럼", color: Colors.lecturePurple, size: 14, font: .notoSansBold)
                        Spacer()
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 8)
                    
                    Rectangle()
                        .foregroundColor(Colors.lineGray)
                        .frame(height: 1)
                        .padding(.horizontal, 16)
                    
                    VStack(alignment: .leading) {
                        ForEach(viewModel.lectureList.indices, id:\.self, content: { idx in
                            
                            ZStack(alignment: .leading) {
                                
                                if idx != viewModel.lectureList.count - 1 {
                                    HStack(spacing: 0) {
                                        
                                        Rectangle()
                                            .frame(width: 2)
                                            .foregroundColor(Colors.applyPurple)
                                            .padding(.leading, 7.4)
                                            .padding(.top, 8)
                                            .padding(.bottom, -20)
                                        
                                        Spacer()
                                    }
                                }
                                
                                VStack(alignment: .leading, spacing: 8) {
                                    HStack(alignment: .top) {
                                        ZStack {
                                            Circle()
                                                .foregroundColor(.white)
                                                .frame(width: 16, height: 16)
                                            Circle()
                                                .stroke(Colors.applyPurple, lineWidth: 2)
                                                .frame(width: 16, height: 16)
                                        }
                                        .padding(.top, 6.5)
                                        
                                        NotoText(text: viewModel.lectureList[idx].title, color: .black, size: 18, font: .notoSansBold, textAlignment: .leading)
                                    }
                                    
                                    NotoText(text: viewModel.lectureList[idx].description, color: .black, size: 14, font: .notoSansRegular, textAlignment: .leading)
                                        .padding(.leading, 24)
                                }
                            }
                            .fixedSize(horizontal: false, vertical: true)
                            
                            
                        })
                    }
                    .padding(.horizontal, 16)
                    
                    
                    Spacer()
                        .frame(height: 100)
                    
                }
                .ignoresSafeArea(edges: .bottom)
                
                
                VStack {
                    Spacer()
                    
                    LinearGradient(gradient: Gradient(colors: [.white.opacity(0.0), .white]), startPoint: .top, endPoint: .bottom)
                        .frame(height: 80)
                }
                .ignoresSafeArea(edges: .bottom)
                
                VStack {
                    Spacer()
                    
                    Button(action: {
                        
                    }, label: {
                        
                        ZStack {
                            
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(Colors.applyPurple)
                            
                            
                            NotoText(text: "수강 신청", color: .white, size: 16,font: .notoSansBold)
                        }
                        
                    })
                    .buttonStyle(PressButtonStyle())
                    .padding(.horizontal, 16)
                    .frame( height: 48)
                }
                .padding(.bottom, 16)
                
            }
            
            Spacer()
        }
        .navigationBarBackButtonHidden()
        .onAppear {
            viewModel.getItems()
        }
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
            .padding(.vertical, 16)
            .padding(.horizontal, 16)
            Spacer()
            
        }
    }
    
    func close() {
        presentationMode.wrappedValue.dismiss()
    }
}

extension DetailView {
    func imageInitTitle(_ imageUrl: String, _ logoUrl: String, _ title: String) -> some View {
        
        VStack(spacing: 0) {

            HStack(spacing: 8) {
                ZStack {
                    RoundedRectangle(cornerRadius: 8)
                        .foregroundColor(Colors.logoBackgroundGray)
                        .frame(width: 36, height: 36)
                    
                    KFImage(URL(string: logoUrl))
                        .resizable()
                        .scaledToFit()
                        .frame(width: 34, height: 34)
                }
                .padding(.vertical, 8)
                .padding(.leading, 16)
                
                NotoText(text: title, color: .black, size: 16, font: .notoSansBold, textAlignment: .leading)
                
                Spacer()
            }
            .padding(.top, 16)
            
            
            KFImage(URL(string: imageUrl))
                .resizable()
                .aspectRatio(2/1, contentMode: .fit)
        }
        

    }
    
    func notImageInitTitle(_ title: String, shortDescrpition: String, logoUrl: String) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            
            HStack {
                
                ZStack {
                    RoundedRectangle(cornerRadius: 8)
                        .foregroundColor(Colors.logoBackgroundGray)
                        .frame(width: 56, height: 56)
                    
                    KFImage(URL(string: logoUrl))
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                }
                
                Spacer()
            }
            .padding(.top, 24)
            
            NotoText(text: title, color: .black, size: 28, font: .notoSansBold, textAlignment: .leading)
            
            NotoText(text: shortDescrpition, color: .black, size: 12, font: .notoSansRegular, textAlignment: .leading)
            
        }
        .padding(.horizontal, 16)
    }
    
    func descriptionView(_ description: String) -> some View {
        Parma(description, render: MyRender())
            .padding(.horizontal, 16)
    }
}

struct DetailView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        DetailView(viewModel: .init(service: Service(webRepository: .init("https://api-rest.elice.io/org/academy/")), courseId: 78001))
        
    }
}

struct MyRender: ParmaRenderable {
    
    func imageView(with urlString: String, altTextView: AnyView?) -> AnyView {
        AnyView(
            
            KFImage(URL(string: urlString))
                .resizable()
                .scaledToFit()
        )
    }
}
