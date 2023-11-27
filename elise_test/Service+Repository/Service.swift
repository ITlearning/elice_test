//
//  Service.swift
//  elise_test
//
//  Created by Tabber on 2023/11/26.
//

import Foundation
import Combine

protocol ServiceProtocol {
    // MARK: API
    func getCourseList(offset: Int, count: Int, filterIsRecommend: Bool?, filterIsFree: Bool?, filterConditions: [String: Any]?) -> AnyPublisher<CourseListModel?, Error>
    func getLectureList(offset: Int, count: Int, courseId: Int) -> AnyPublisher<LectureListModel?, Error>
    func getCourseItem(courseId: Int) -> AnyPublisher<CourseItemModel?, Error>
    
    // MARK: - CoreData
    func saveLectureID(_ lectureID: Int) -> AnyPublisher<Void, Error>
    func loadLectureIDs() -> AnyPublisher<[LectureCDModel], Error>
    func deleteLectureID(_ lectureID: Int) -> AnyPublisher<Void, Error>
}

struct Service: ServiceProtocol {
    private let webRepository: WebRepository
    private let dbRepository: DBRepository
    
    private let cancelBag = CancelBag()
    
    init(webRepository: WebRepository) {
        self.webRepository = webRepository
        self.dbRepository = DBRepository()
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
    
    
    func saveLectureID(_ lectureID: Int) -> AnyPublisher<Void, Error> {
        return dbRepository.saveLectureID(lectureID)
    }
    
    func loadLectureIDs() -> AnyPublisher<[LectureCDModel], Error> {
        return dbRepository.loadLectureIDs()
    }
    
    func deleteLectureID(_ lectureID: Int) -> AnyPublisher<Void, Error> {
        return dbRepository.deleteLectureID(lectureID)
    }
    
    
}
