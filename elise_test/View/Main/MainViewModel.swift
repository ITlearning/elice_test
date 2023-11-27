//
//  MainViewModel.swift
//  elise_test
//
//  Created by Tabber on 2023/11/26.
//

import SwiftUI
import Combine

enum CourseType {
    case free
    case recommend
    case contition(value: [String: Any])
}

struct LoadMoreModel {
    var isLoad: Bool
    var offset: Int
    var last: Bool
}

extension MainView {
    class ViewModel: ObservableObject {
        var service: Service
        private var cancelBag = CancelBag()
        
        var isInit: Bool = false
        
        @Published var courseList: [Course] = []
        @Published var recommendCourseList: [Course] = []
        @Published var conditionsCourseList: [Course] = []
        
        private var freeFreeLoad = LoadMoreModel(isLoad: false, offset: 0, last: false)
        private var recommendCourseFreeLoad = LoadMoreModel(isLoad: false, offset: 0, last: false)
        private var conditionCourseFreeLoad = LoadMoreModel(isLoad: false, offset: 0, last: false)
        
        var isLoad: Bool = false
        
        init(service: Service) {
            self.service = service
        }
        
        func setDatas() {
            Task {
                let _ = await getCourseList(.free)
                let _ = await getCourseList(.recommend)
            }
        }
        
        func freeLoadMore(idx: Int) {
            
            guard idx >= courseList.count - 1 else { return }
            
            Task {
                let _ = await getCourseList(.free, loadMore: true)
            }
        }
        
        func recommendLoadMore(idx: Int) {
            
            guard idx >= recommendCourseList.count - 1 else { return }
            
            Task {
                let _ = await getCourseList(.recommend, loadMore: true)
            }
        }
        
        func getCourseList(_ type: CourseType, count: Int = 10, loadMore: Bool = false) async -> Result<Bool, Error> {
            
            print("[@] type", type)
            
            return await withCheckedContinuation({ continuation in
                
                var free: Bool? = nil
                var recommend: Bool? = nil
                var conditions: [String: Any]? = nil
                
                switch type {
                case .free:
                    free = true
                case .recommend:
                    recommend = true
                case .contition(let value):
                    conditions = value
                }
                
                switch type {
                case .free:
                    guard !freeFreeLoad.isLoad || !freeFreeLoad.last else {
                        return continuation.resume(returning: .success(false))
                    }
                case .recommend:
                    guard !recommendCourseFreeLoad.isLoad || !recommendCourseFreeLoad.last else {
                        return continuation.resume(returning: .success(false))
                    }
                case .contition:
                    guard !conditionCourseFreeLoad.isLoad || !conditionCourseFreeLoad.last else {
                        return continuation.resume(returning: .success(false))
                    }
                }
                
                if loadMore {
                    switch type {
                    case .contition:
                        conditionCourseFreeLoad.isLoad = true
                        conditionCourseFreeLoad.offset += 1
                    case .free:
                        freeFreeLoad.isLoad = true
                        freeFreeLoad.offset += 1
                    case .recommend:
                        recommendCourseFreeLoad.isLoad = true
                        recommendCourseFreeLoad.offset += 1
                    }
                } else {
                    switch type {
                    case .contition:
                        conditionCourseFreeLoad.isLoad = true
                        conditionCourseFreeLoad.offset = 1
                    case .free:
                        freeFreeLoad.isLoad = true
                        freeFreeLoad.offset = 1
                    case .recommend:
                        recommendCourseFreeLoad.isLoad = true
                        recommendCourseFreeLoad.offset = 1
                    }
                }
                
                var offset: Int = 1
                
                switch type {
                case .contition:
                    offset = conditionCourseFreeLoad.offset
                case .free:
                    offset = freeFreeLoad.offset
                case .recommend:
                    offset = recommendCourseFreeLoad.offset
                }
                
                service.getCourseList(offset: offset, count: count, filterIsRecommend: recommend, filterIsFree: free, filterConditions: conditions)
                    .receive(on: DispatchQueue.main)
                    .sink(receiveCompletion: { result in
                        switch result {
                        case .failure(let error):
                            print("error", error.localizedDescription)
                            continuation.resume(returning: .failure(error))
                        case .finished:
                            print("finished")
                            continuation.resume(returning: .success(true))
                        }
                        
                    }, receiveValue: { value in
                        switch type {
                        case .free:
                            if loadMore {
                                self.courseList += value?.courses ?? []
                            } else {
                                self.courseList = value?.courses ?? []
                            }
                           
                            if (value?.courses ?? []).isEmpty {
                                self.freeFreeLoad.last = true
                            }
                            
                        case .recommend:
                            if loadMore {
                                self.recommendCourseList += value?.courses ?? []
                            } else {
                                self.recommendCourseList = value?.courses ?? []
                            }
                            
                            if (value?.courses ?? []).isEmpty {
                                self.recommendCourseFreeLoad.last = true
                            }
                            
                        case .contition:
                            if loadMore {
                                self.conditionsCourseList += value?.courses ?? []
                            } else {
                                self.conditionsCourseList = value?.courses ?? []
                            }
                            
                            if (value?.courses ?? []).isEmpty {
                                self.conditionCourseFreeLoad.last = true
                            }
                        }
                        
                        switch type {
                        case .contition:
                            self.conditionCourseFreeLoad.isLoad = false
                        case .free:
                            self.freeFreeLoad.isLoad = false
                        case .recommend:
                            self.recommendCourseFreeLoad.isLoad = false
                        }
                        
                    })
                    .cancel(with: self.cancelBag)
            })

        }
        
    }
}
