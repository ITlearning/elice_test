//
//  MainView.swift
//  elise_test
//
//  Created by Tabber on 2023/11/26.
//

import SwiftUI
import SDWebImageSwiftUI

struct MainView: View {
    
    @StateObject var viewModel: ViewModel
    
    var body: some View {
        
        
        VStack(alignment:.leading, spacing: 0) {
            HStack(spacing: 0) {
                
                Image("Left")
                Spacer()
                
                Button(action: {
                    
                }, label: {
                    Image("Right")
                })
                
            }
            .padding(.horizontal, 16)
            
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    freeCourseView
                    recommendCourseView
                }
            }
        }
        .onAppear {
            viewModel.setDatas()
        }
    }
    
    var freeCourseView: some View {
        VStack(alignment: .leading, spacing: 0) {
            NotoText(text: "무료 과목", size: 16, font: .notoSansBold)
                .padding(.top, 8)
                .padding(.leading, 16)
            
            ScrollView(.horizontal, showsIndicators: false , content: {
                
                HStack(alignment: .top, spacing: 0) {
                    Spacer()
                        .frame(width: 16)
                    
                    LazyHGrid(rows: [.init()], spacing: 16, content: {
                        ForEach((viewModel.courseList).indices, id: \.self) { idx in
                            let item = viewModel.courseList[idx]
                            Button(action: {
                                
                                
                            }, label: {
                                CourseItemView(item: item)
                            })
                            .onAppear {
                                viewModel.freeLoadMore(idx: idx)
                            }
                        }
                    })
                    
                    Spacer()
                        .frame(width: 16)
                }
                
            })
            .padding(.top, 16)
        }
        
    }
    
    var recommendCourseView: some View {
        
        VStack(alignment: .leading, spacing: 0, content: {
            NotoText(text: "추천 과목", size: 16, font: .notoSansBold)
                .padding(.top, 8)
                .padding(.leading, 16)
            
            ScrollView(.horizontal, showsIndicators: false , content: {
                
                HStack(alignment: .top, spacing: 0) {
                    
                    
                    Spacer()
                        .frame(width: 16)
                    
                    LazyHGrid(rows: [.init()], spacing: 16, content: {
                        ForEach(viewModel.recommendCourseList.indices, id: \.self) { idx in
                            let item = viewModel.recommendCourseList[idx]
                            
                            Button(action: {
                                
                            }, label: {
                                CourseItemView(item: item)
                            })
                            .onAppear {
                                viewModel.recommendLoadMore(idx: idx)
                            }
                                
                        }
                    })
                    
                    Spacer()
                        .frame(width: 16)
                }
                
            })
            .padding(.top, 16)
        })
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(viewModel: .init(service: Service(webRepository: .init("https://api-rest.elice.io/org/academy/"))))
    }
}
