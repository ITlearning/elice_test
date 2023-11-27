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
        private var courseId: Int
        
        var service: Service
        var cancelBag = CancelBag()
        
        
        @Published var lectureList: [Lecture] = []
        @Published var course: Course? = nil
        
        init(service: Service, courseId: Int) {
            self.service = service
            self.courseId = courseId
        }
        
        func getItems() {
            Task {
                let _ = await getCourseItem()
                let _ = await getLectureList()
            }
        }
        
        func getCourseItem() async -> Result<Bool, Error> {
            
            return await withCheckedContinuation({ continuation in
                self.service.getCourseItem(courseId: courseId)
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
                    }, receiveValue: { [weak self] value in
                        guard let self = self else { return }
                        self.course = value?.course
                    })
                    .cancel(with: self.cancelBag)
            })
            
            
        }
        
        func getLectureList() async -> Result<Bool, Error> {
            
            return await withCheckedContinuation({ continuation in
                self.service.getLectureList(offset: 0, count: 40, courseId: course?.id ?? 78960)
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
                         
                    }, receiveValue: { [weak self] value in
                        guard let self = self else { return }
                        self.lectureList = value?.lectures ?? []
                        
                        print("[@] Success", self.lectureList)
                    })
                    .cancel(with: self.cancelBag)
            })
            
            
        }
    }
}
