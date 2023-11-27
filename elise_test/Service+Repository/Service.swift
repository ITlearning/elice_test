//
//  Service.swift
//  elise_test
//
//  Created by Tabber on 2023/11/26.
//

import Foundation
import Combine

protocol ServiceProtocol {
    func getCourseList(offset: Int, count: Int, filterIsRecommend: Bool?, filterIsFree: Bool?, filterConditions: [String: Any]?) -> AnyPublisher<CourseListModel?, Error>
    func getLectureList(offset: Int, count: Int, courseId: Int) -> AnyPublisher<LectureListModel?, Error>
    func getCourseItem(courseId: Int) -> AnyPublisher<CourseItemModel?, Error>
}

struct Service: ServiceProtocol {
    private let webRepository: WebRepository
    
    private let cancelBag = CancelBag()
    
    init(webRepository: WebRepository) {
        self.webRepository = webRepository
    }
    
    func getCourseItem(courseId: Int) -> AnyPublisher<CourseItemModel?, Error> {
        return webRepository.getCourseItem(courseId: courseId)
    }
    
    func getLectureList(offset: Int, count: Int, courseId: Int) -> AnyPublisher<LectureListModel?, Error> {
        return webRepository.getLectureList(offset: offset, count: count, courseId: courseId)
    }
    
    func getCourseList(offset: Int, count: Int, filterIsRecommend: Bool?, filterIsFree: Bool?, filterConditions: [String : Any]?) -> AnyPublisher<CourseListModel?, Error> {
        return webRepository.getCourseList(offset: offset, count: count, filterIsRecommend: filterIsRecommend, filterIsFree: filterIsFree, filterConditions: filterConditions)
    }
    
    
    
}
