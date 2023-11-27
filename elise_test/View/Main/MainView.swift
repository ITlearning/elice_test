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
        
        NavigationView {
            
            ScrollViewReader { reader in
                VStack(alignment:.leading, spacing: 0) {
                    HStack(spacing: 0) {
                        
                        Image("Left")
                            .frame(height: 32)
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
                            if !viewModel.conditionsCourseList.isEmpty {
                                conditionCourseView
                            }
                        }
                    }
                }
                .task {
                    if !viewModel.isInit {
                        viewModel.setDatas()
                        viewModel.isInit = true
                    } else {
                        viewModel.updateCheckMyLectures()
                    }
                    
                }
            }
            
        }
    }
    
    var freeCourseView: some View {
        VStack(alignment: .leading, spacing: 0) {
            NotoText(text: "무료 과목", size: 16, font: .notoSansBold)
                .padding(.top, 8)
                .padding(.leading, 16)
            
            if viewModel.courseList.isEmpty {
                lodingView
            } else {
                ScrollView(.horizontal, showsIndicators: false , content: {
                    
                    HStack(alignment: .top, spacing: 0) {
                        Spacer()
                            .frame(width: 16)
                        
                        LazyHGrid(rows: [.init()], spacing: 16, content: {
                            ForEach((viewModel.courseList).indices, id: \.self) { idx in
                                let item = viewModel.courseList[idx]
                                
                                NavigationLink(destination: {
                                    DetailView(viewModel: .init(service: viewModel.service, courseId: item.id))
                                }, label: {
                                    CourseItemView(item: item)
                                        .frame(width: 200, height: 220)
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
                .padding(.bottom, 24)
            }
        }
        
    }
    
    var recommendCourseView: some View {
        
        VStack(alignment: .leading, spacing: 0, content: {
            NotoText(text: "추천 과목", size: 16, font: .notoSansBold)
                .padding(.top, 8)
                .padding(.leading, 16)
            
            if viewModel.recommendCourseList.isEmpty {
                lodingView
            } else {
                ScrollView(.horizontal, showsIndicators: false , content: {
                    
                    HStack(alignment: .top, spacing: 0) {
                        
                        
                        Spacer()
                            .frame(width: 16)
                        
                        LazyHGrid(rows: [.init()], spacing: 16, content: {
                            ForEach(viewModel.recommendCourseList.indices, id: \.self) { idx in
                                let item = viewModel.recommendCourseList[idx]
                                
                                NavigationLink(destination: {
                                    DetailView(viewModel: .init(service: viewModel.service, courseId: item.id))
                                }, label: {
                                    CourseItemView(item: item)
                                        .frame(width: 200, height: 220)
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
                .padding(.bottom, 24)
            }
            
        })
    }
    
    var conditionCourseView: some View {
        VStack(alignment: .leading, spacing: 0, content: {
            NotoText(text: "내 학습", size: 16, font: .notoSansBold)
                .padding(.top, 8)
                .padding(.leading, 16)
            
            ScrollView(.horizontal, showsIndicators: false , content: {
                
                HStack(alignment: .top, spacing: 0) {
                    
                    
                    Spacer()
                        .frame(width: 16)
                    
                    LazyHGrid(rows: [.init()], spacing: 16, content: {
                        ForEach(viewModel.conditionsCourseList.indices, id: \.self) { idx in
                            let item = viewModel.conditionsCourseList[idx]
                            
                            NavigationLink(destination: {
                                DetailView(viewModel: .init(service: viewModel.service, courseId: item.id))
                            }, label: {
                                CourseItemView(item: item)
                                    .frame(width: 200, height: 220)
                            })
                            .onAppear {
                                viewModel.conditionLoadMore(idx: idx)
                            }
                            .id(item.id)
                         
                                
                        }
                    })
                    
                    Spacer()
                        .frame(width: 16)
                }
                
            })
            .padding(.top, 16)
        })
    }
    
    var lodingView: some View {
        HStack {
            Spacer()
            NotoText(text: "로딩중..!")
                .frame(height: 230)
            Spacer()
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(viewModel: .init(service: Service(webRepository: .init("https://api-rest.elice.io/org/academy/"))))
    }
}
