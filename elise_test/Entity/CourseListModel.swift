//
//  CourseListModel.swift
//  elise_test
//
//  Created by Tabber on 2023/11/26.
//

import Foundation

// MARK: - CourseListModel
struct CourseListModel: Codable {
    let result: ResultModel
    let courses: [Course]?
    let courseCount: Int

    enum CodingKeys: String, CodingKey {
        case result = "_result"
        case courses
        case courseCount = "course_count"
    }
}

// MARK: - Course
struct Course: Codable {
    let id: Int
    let isRecommended, isChatRoomDisabled, isPostStudentInfoVisible, isPostStudentEmailEnabled: Bool
    let isPostTutorEmailEnabled: Bool
    let preference: Preference?
    let enrollBeginDatetime: Int
    let enrollEndDatetime: Int?
    let releaseDatetime, beginDatetime: Int?
    let endDatetime, completeDatetime: Int?
    let enrolledRolePeriod, enrollType: Int?
    let subscriptionLevel, enrollLimitNumber: Int?
    let price, priceUsd: String
    let unit: Int?
    let discountedPrice, discountedPriceUsd: String
    let discountBeginDatetime, discountEndDatetime: Int?
    let discountTitle, discountRate: String?
    let completionInfo: CompletionInfo?
    let courseType: Int
    let infoSummaryVisibilityDict: InfoSummaryVisibilityDict
    let isExerciseDeprecated: Bool
    let lastCourseInfoID: Int
    let title, code, shortDescription: String
    let classTimes: [String]
    let classType: Int
    let taglist: [String]
    let promoteVideoURL: String?
    let logoFileURL, imageFileURL: String?
    let period, version: Int
    let isDiscounted: Bool
    let attendInfo: AttendInfo
    let lastAttendUpdatedDate: String?
    let leaderboardRankingType: Int
    let leaderboardInfo: LeaderboardInfo
    let isFree: Bool
    let status: Int
    let libraryAccessType, libraryCredit: String?
    let libraryType: Int
    let isEnrollNotiEnabled, isDatetimeEnrollable: Bool
    let agreementInfo: AgreementInfo
    let isEnrollGuestEnabled, isLegacyTest: Bool
    let lastReviewStatus: Int
    let courseAgreedDatetime: String?
    let courseRole: Int
    let hasPastCourseRole: Bool
    let ern: String
    let aibotInfo: AibotInfo
    let enrolledUserCount, enrolledStudentCount, normalLectureCount, testLectureCount: Int
    let normalLecturePageCount: Int
    let isLibraryMaterialInstanceExist, isLibraryMaterialInstanceSyncEnabled: Bool
    let enrolledRoleBeginDatetime, enrolledRoleEndDatetime, lecturePageReadInfo: String?
    let tracks: [Track]?
    let tags: [Tag]?
    let instructors: [Instructor]?
    let testLecture: String?

    enum CodingKeys: String, CodingKey {
        case id
        case isRecommended = "is_recommended"
        case isChatRoomDisabled = "is_chat_room_disabled"
        case isPostStudentInfoVisible = "is_post_student_info_visible"
        case isPostStudentEmailEnabled = "is_post_student_email_enabled"
        case isPostTutorEmailEnabled = "is_post_tutor_email_enabled"
        case preference
        case enrollBeginDatetime = "enroll_begin_datetime"
        case enrollEndDatetime = "enroll_end_datetime"
        case releaseDatetime = "release_datetime"
        case beginDatetime = "begin_datetime"
        case endDatetime = "end_datetime"
        case completeDatetime = "complete_datetime"
        case enrolledRolePeriod = "enrolled_role_period"
        case enrollType = "enroll_type"
        case subscriptionLevel = "subscription_level"
        case enrollLimitNumber = "enroll_limit_number"
        case price
        case priceUsd = "price_usd"
        case unit
        case discountedPrice = "discounted_price"
        case discountedPriceUsd = "discounted_price_usd"
        case discountBeginDatetime = "discount_begin_datetime"
        case discountEndDatetime = "discount_end_datetime"
        case discountTitle = "discount_title"
        case discountRate = "discount_rate"
        case completionInfo = "completion_info"
        case courseType = "course_type"
        case infoSummaryVisibilityDict = "info_summary_visibility_dict"
        case isExerciseDeprecated = "is_exercise_deprecated"
        case lastCourseInfoID = "last_course_info_id"
        case title, code
        case shortDescription = "short_description"
        case classTimes = "class_times"
        case classType = "class_type"
        case taglist
        case promoteVideoURL = "promote_video_url"
        case logoFileURL = "logo_file_url"
        case imageFileURL = "image_file_url"
        case period, version
        case isDiscounted = "is_discounted"
        case attendInfo = "attend_info"
        case lastAttendUpdatedDate = "last_attend_updated_date"
        case leaderboardRankingType = "leaderboard_ranking_type"
        case leaderboardInfo = "leaderboard_info"
        case isFree = "is_free"
        case status
        case libraryAccessType = "library_access_type"
        case libraryCredit = "library_credit"
        case libraryType = "library_type"
        case isEnrollNotiEnabled = "is_enroll_noti_enabled"
        case isDatetimeEnrollable = "is_datetime_enrollable"
        case agreementInfo = "agreement_info"
        case isEnrollGuestEnabled = "is_enroll_guest_enabled"
        case isLegacyTest = "is_legacy_test"
        case lastReviewStatus = "last_review_status"
        case courseAgreedDatetime = "course_agreed_datetime"
        case courseRole = "course_role"
        case hasPastCourseRole = "has_past_course_role"
        case ern
        case aibotInfo = "aibot_info"
        case enrolledUserCount = "enrolled_user_count"
        case enrolledStudentCount = "enrolled_student_count"
        case normalLectureCount = "normal_lecture_count"
        case testLectureCount = "test_lecture_count"
        case normalLecturePageCount = "normal_lecture_page_count"
        case isLibraryMaterialInstanceExist = "is_library_material_instance_exist"
        case isLibraryMaterialInstanceSyncEnabled = "is_library_material_instance_sync_enabled"
        case enrolledRoleBeginDatetime = "enrolled_role_begin_datetime"
        case enrolledRoleEndDatetime = "enrolled_role_end_datetime"
        case lecturePageReadInfo = "lecture_page_read_info"
        case tags, tracks, instructors
        case testLecture = "test_lecture"
    }
}

/*
 "id": 3973,
 "title": "TOPA 6주완성 합격 PATH"
 */

struct Track: Codable {
    let id: Int
    let title: String
}


// MARK: - Tag
struct Tag: Codable, Hashable {
    let id: Int
    let tagType: Int
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case tagType = "tag_type"
        case name
    }
}

// MARK: - Instructor
struct Instructor: Codable {
    let id: Int?
    let fullname: String?
    let firstname: String?
    let lastname: String?
    let profileUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case fullname
        case firstname
        case lastname
        case profileUrl = "profile_url"
    }
}


// MARK: - AgreementInfo
struct AgreementInfo: Codable {
    let title: String
    let isEnabled: Bool
    let description: String

    enum CodingKeys: String, CodingKey {
        case title
        case isEnabled = "is_enabled"
        case description
    }
}

// MARK: - AibotInfo
struct AibotInfo: Codable {
    let isEnabled: Bool

    enum CodingKeys: String, CodingKey {
        case isEnabled = "is_enabled"
    }
}

// MARK: - AttendInfo
struct AttendInfo: Codable {
    let isEnabled: Bool
    let activeEndDate, activeBeginDate, checkInEndTime, checkOutEndTime: String
    let checkInBeginTime, checkOutBeginTime: String
    let requiredStaySeconds: Int

    enum CodingKeys: String, CodingKey {
        case isEnabled = "is_enabled"
        case activeEndDate = "active_end_date"
        case activeBeginDate = "active_begin_date"
        case checkInEndTime = "check_in_end_time"
        case checkOutEndTime = "check_out_end_time"
        case checkInBeginTime = "check_in_begin_time"
        case checkOutBeginTime = "check_out_begin_time"
        case requiredStaySeconds = "required_stay_seconds"
    }
}

// MARK: - CompletionInfo
struct CompletionInfo: Codable {
    let unit: Unit?
    let condition: Condition?
    let certificateInfo: CertificateInfo?

    enum CodingKeys: String, CodingKey {
        case unit, condition
        case certificateInfo = "certificate_info"
    }
}

// MARK: - CertificateInfo
struct CertificateInfo: Codable {
    let isEnabled: Bool
    let templateID: String

    enum CodingKeys: String, CodingKey {
        case isEnabled = "is_enabled"
        case templateID = "template_id"
    }
}

// MARK: - Condition
struct Condition: Codable {
    let score, progress: Int
    let isEnabled: Bool

    enum CodingKeys: String, CodingKey {
        case score, progress
        case isEnabled = "is_enabled"
    }
}

// MARK: - Unit
struct Unit: Codable {
    let value: Double?
    let isEnabled: Bool

    enum CodingKeys: String, CodingKey {
        case value
        case isEnabled = "is_enabled"
    }
}

// MARK: - InfoSummaryVisibilityDict
struct InfoSummaryVisibilityDict: Codable {
    let level, period, classType, classTimes: Bool
    let completionUnit, exercisePageCount, completionCondition, programmingLanguage: Bool
    let totalVideoDuration, enrolledStudentCount, lecturePageAccessPeriod: Bool

    enum CodingKeys: String, CodingKey {
        case level, period
        case classType = "class_type"
        case classTimes = "class_times"
        case completionUnit = "completion_unit"
        case exercisePageCount = "exercise_page_count"
        case completionCondition = "completion_condition"
        case programmingLanguage = "programming_language"
        case totalVideoDuration = "total_video_duration"
        case enrolledStudentCount = "enrolled_student_count"
        case lecturePageAccessPeriod = "lecture_page_access_period"
    }
}

// MARK: - LeaderboardInfo
struct LeaderboardInfo: Codable {
    let entryType, scoreType, rankingType: Int

    enum CodingKeys: String, CodingKey {
        case entryType = "entry_type"
        case scoreType = "score_type"
        case rankingType = "ranking_type"
    }
}

// MARK: - Preference
struct Preference: Codable {
    let boards, images, manage, configs: Bool?
    let landing: Landing?
    let members, lectures, requests, sections: Bool?
    let tutoring, dashboard, libraries, attendance: Bool?
    let leaderboard, lectureroom, aiDashboard, attendanceAdmin: Bool?
    let sectionSchedule: Bool?

    enum CodingKeys: String, CodingKey {
        case boards, images, manage, configs, landing, members, lectures, requests, sections, tutoring, dashboard, libraries, attendance, leaderboard, lectureroom
        case aiDashboard = "ai_dashboard"
        case attendanceAdmin = "attendance_admin"
        case sectionSchedule = "section_schedule"
    }
}

// MARK: - Landing
struct Landing: Codable {
    let mode: String
    let configsV2: ConfigsV2?

    enum CodingKeys: String, CodingKey {
        case mode
        case configsV2 = "configs_v2"
    }
}

// MARK: - ConfigsV2
struct ConfigsV2: Codable {
    let bgColor: String
    let sections: [Section]
    let titleColor, adBannerLink, promotionType, coverImageURL: String
    let adBannerImageURL, shortDescriptionColor: String

    enum CodingKeys: String, CodingKey {
        case bgColor = "bg_color"
        case sections
        case titleColor = "title_color"
        case adBannerLink = "ad_banner_link"
        case promotionType = "promotion_type"
        case coverImageURL = "cover_image_url"
        case adBannerImageURL = "ad_banner_image_url"
        case shortDescriptionColor = "short_description_color"
    }
}

// MARK: - Section
struct Section: Codable {
    let type, uuid: String
    let payload: Payload
}

// MARK: - Payload
struct Payload: Codable {
    let cards: [Card]?
    let label, title: String
    let visible: Bool
    let alignMode: String?
    let description: String
    let anchorEnabled: Bool
    let objectives: [Objective]?
    let content, fileURL: String?
    let faqs: [FAQ]?

    enum CodingKeys: String, CodingKey {
        case cards, label, title, visible
        case alignMode = "align_mode"
        case description
        case anchorEnabled = "anchor_enabled"
        case objectives, content
        case fileURL = "file_url"
        case faqs
    }
}

// MARK: - Card
struct Card: Codable {
    let title: String
    let caption: String?
    let imageURL: String?
    let description: String

    enum CodingKeys: String, CodingKey {
        case title, caption
        case imageURL = "image_url"
        case description
    }
}

// MARK: - FAQ
struct FAQ: Codable {
    let answer, question: String
}

// MARK: - Objective
struct Objective: Codable {
    let title: String
    let description: String?
}

// MARK: - Result
struct ResultModel: Codable {
    let status: String
    let reason: String?
}
