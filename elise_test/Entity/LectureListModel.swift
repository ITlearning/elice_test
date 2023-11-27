//
//  LectureListModel.swift
//  elise_test
//
//  Created by Tabber on 2023/11/27.
//

import Foundation

// MARK: - LectureListModel
struct LectureListModel: Codable {
    let result: ResultModel
    let lectures: [Lecture]
    let lectureCount: Int

    enum CodingKeys: String, CodingKey {
        case result = "_result"
        case lectures
        case lectureCount = "lecture_count"
    }
}

// MARK: - Lecture
struct Lecture: Codable {
    let id, lectureType, orderNo: Int
    let title, description: String
    let teachingDatetime, openScheduleDatetime, closeScheduleDatetime: Int?
    let isOpened, isPreview: Bool
    let testBeginDatetime: Int?
    let testEndDatetime, testDuration: Int?
    let testDescription: String?
    let isTestAccessibleAfterCompletion: Bool?
    let testQualification: Bool?
    let isTestResetEnabledByStudent: Bool?
    let isTestScoreOpened: Bool?
    let testScoreOpenDatetime: Int?
    let lectureGroupTotalPoint: Int?
    let cheatInfo: String?
    let totalPageCount, totalPagePoint: Int

    enum CodingKeys: String, CodingKey {
        case id
        case lectureType = "lecture_type"
        case orderNo = "order_no"
        case title, description
        case teachingDatetime = "teaching_datetime"
        case openScheduleDatetime = "open_schedule_datetime"
        case closeScheduleDatetime = "close_schedule_datetime"
        case isOpened = "is_opened"
        case isPreview = "is_preview"
        case testBeginDatetime = "test_begin_datetime"
        case testEndDatetime = "test_end_datetime"
        case testDuration = "test_duration"
        case testDescription = "test_description"
        case isTestAccessibleAfterCompletion = "is_test_accessible_after_completion"
        case testQualification = "test_qualification"
        case isTestResetEnabledByStudent = "is_test_reset_enabled_by_student"
        case isTestScoreOpened = "is_test_score_opened"
        case testScoreOpenDatetime = "test_score_open_datetime"
        case lectureGroupTotalPoint = "lecture_group_total_point"
        case cheatInfo = "cheat_info"
        case totalPageCount = "total_page_count"
        case totalPagePoint = "total_page_point"
    }
}
