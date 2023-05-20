//
//  Constants.swift
//  GymCare
//
//  Created by Nguyễn Hà on 27/12/2022.
//

import Foundation
import UIKit

struct Constants {
    static let WIDTH_SCREEN = UIScreen.main.bounds.width
    static let HEIGHT_SCREEN = UIScreen.main.bounds.height
    static let TIME_OUT: Double = 60
    static let MAX_UPLOAD_IMAGE: Float = 2.0
    static let DEALY_TIME = DispatchTimeInterval.seconds(1)
    static let DATE_TIME_FORMAT = "yyyy-MM-dd hh:mm:ss"
    static let DATE_TIME_FORMAT_2 = "dd/MM/yyyy HH:mm:ss"
    static let DATE_TIME_FORMAT_3 = "hh:mm, dd/MM/yyyy"
    static let DATE_TIME_FORMAT_4 = "hh:mm, dd/MM"
    static let DATE_MONTH_FORMAT = "dd/MM"
    static let DATE_FORMAT = "dd/MM/yyyy"
    static let DATE_FORMAT_2 = "yyyy/MM/dd"
    static let DATE_PARAM_FORMAT = "yyyy-MM-dd"
    static let YEAR_STRING = "yyyy"
    static let MONTH_STRING = "MM"
    static let MONTH_STYLE_STRING = "MM/yyyy"
    static let MONTH_PARAM_STRING = "MM-yyyy"
    static let MONTH_PARAM_STRING_2 = "yyyy-MM"
    static let QUARTER_STYLE_STRING = "q/yyyy"
    static let QUARTER_STRING = "q"
    static let DAY_STRING = "dd"
    static let HOUR_STRING = "HH:mm"
    static let HOUR_STRING_MIN = "HH:mm:ss"
    static let HOUR_STRING_SYMBOL = "HH:mm a"
    static let HOUR_STRING_SYMBOL_NOMAR = "hh:mm a"
    static let DATE_TIME_FORMAT_24h = "yyyy-MM-dd HH:mm:ss"
    static let DATE_TIME_FORMAT_SYMBOL_24h = "yyyy-MM-dd HH:mm a"
    static let DATE_TIME_FORMAT_SYMBOL = "yyyy-MM-dd hh:mm a"
    static let SUFFIX_JSON = ".php"
    static let minIncome = Double(10000000)
    static let comma = ","
    static let amSymbol = "AM"
    static let pmSymbol = "PM"
    static let dateInWeek = "EEEE"
    static let locateIdentifierEnUS = "en_US_POSIX"
    static var selectedLanguage = "vi"
    static var messages = 2
    static var notification = 1
}

struct EndPointURL {
    static let BASE_URL: String = ""
    static let BASE_API_URL: String = Config.shared.BASE_API_URL
    static let POLICY_URL: String = Config.shared.POLICY_URL
    static let IMAGE_URL: String = Config.shared.BASE_API_URL + "/gymcare/"
    static let versionJson = Config.shared.versionJson
    static let versionJsonOnly = Config.shared.versionJsonOnly
    static let LOGIN: String = versionJson + "login" + Constants.SUFFIX_JSON
    static let USER: String = versionJsonOnly + "controller/trainer" + Constants.SUFFIX_JSON
    static let RESET_PASS: String = versionJson + "password/reset" + Constants.SUFFIX_JSON
    static let UPDATE_PASS: String = versionJson + "password/update" + Constants.SUFFIX_JSON
    static let CHANGE_PASS: String = versionJson + "password/change" + Constants.SUFFIX_JSON
    static let GET_CLASS: String = versionJson + "classes" + Constants.SUFFIX_JSON
    static let GET_TOP: String = versionJson + "top" + Constants.SUFFIX_JSON
    static let GET_ALBUM: String = versionJson + "album" + Constants.SUFFIX_JSON
    static let GET_MENU: String = versionJsonOnly + "student/menu" + Constants.SUFFIX_JSON
    static let COMMENT_MENU: String = versionJson + "menu/comment" + Constants.SUFFIX_JSON
    static let GET_SCHEDULE: String = versionJsonOnly + "student/schedule" + Constants.SUFFIX_JSON
    static let COMMENT_SCHEDULE: String = versionJson + "schedule/comment" + Constants.SUFFIX_JSON
    static let LIKE_ALBUM: String = versionJson + "album/like" + Constants.SUFFIX_JSON
    static let ALBUM_DETAIL: String = versionJson + "album/detail" + Constants.SUFFIX_JSON
    static let COMMENT_ALBUM: String = versionJson + "album/comment" + Constants.SUFFIX_JSON
    static let GET_NOTIFICATIONS: String = versionJsonOnly + "student/notifications" + Constants.SUFFIX_JSON
    static let GET_INFOR_IN_OUT: String = versionJsonOnly + "student/inout" + Constants.SUFFIX_JSON
    static let GET_NOTI_DETAIL: String = versionJson + "notification/detail" + Constants.SUFFIX_JSON

    static let CONFIRM_STUDENT: String = versionJsonOnly + "checkin/student/update-inout" + Constants.SUFFIX_JSON
    static let GET_LIST_STUDENT: String = versionJsonOnly + "class/students" + Constants.SUFFIX_JSON
    static let GET_INFOR_HEALT: String = versionJsonOnly + "student/healths" + Constants.SUFFIX_JSON
    static let GET_INFOR_POOPEE: String = versionJson + "pee-poo" + Constants.SUFFIX_JSON
    static let EDIT_POO_PEE: String = versionJson + "pee-poo/upsert" + Constants.SUFFIX_JSON
    static let GET_ABSENCE: String = versionJson + "absences" + Constants.SUFFIX_JSON
    static let APPROVE_ABSENCE: String = versionJson + "approve/absence" + Constants.SUFFIX_JSON
    static let ABSENCE_EDIT: String = versionJson + "absence/edit" + Constants.SUFFIX_JSON
    static let GET_STUDENT_DETAIL: String = versionJsonOnly + "student/detail" + Constants.SUFFIX_JSON
    static let UPDATE_STUDENT: String = versionJsonOnly + "student/update" + Constants.SUFFIX_JSON
    static let GET_TOPICS: String = versionJson + "chat" + Constants.SUFFIX_JSON
    static let GET_TOPIC_DETAIL: String = versionJson + "message" + Constants.SUFFIX_JSON
    static let RELOAD_CHAT_DETAIL: String = versionJson + "reload_message" + Constants.SUFFIX_JSON
    static let LIST_REMINDER: String = versionJson + "reminder" + Constants.SUFFIX_JSON
    static let CREATE_REMINDER: String = versionJson + "reminder/create" + Constants.SUFFIX_JSON
    static let EDIT_REMINDER: String = versionJson + "reminder/edit" + Constants.SUFFIX_JSON
    static let UPDATE_STATUS_REMINDER: String = versionJson + "reminder/update-status" + Constants.SUFFIX_JSON
    static let GET_REMINDER: String = versionJson + "reminder/detail" + Constants.SUFFIX_JSON
    static let DELETE_REMINDER: String = versionJson + "reminder/delete" + Constants.SUFFIX_JSON
    static let GET_SETTING_INFO: String = versionJson + "settings" + Constants.SUFFIX_JSON
    static let GET_LIST_SURVEY: String = versionJson + "list-survey-sheets" + Constants.SUFFIX_JSON
    static let CHANGE_LANGUAGE: String = versionJson + "language/change" + Constants.SUFFIX_JSON
    static let GET_TEACHER_INFO: String = versionJson + "detail" + Constants.SUFFIX_JSON
    static let LOGOUT: String = versionJson + "logout" + Constants.SUFFIX_JSON
    static let UPDATE_TEACHER_INFO: String = versionJson + "update" + Constants.SUFFIX_JSON
    static let UPDATE_NOTI_FLAG: String = versionJson + "notification/flag" + Constants.SUFFIX_JSON
    static let CREATE_ALBUM: String = versionJsonOnly + "album/create" + Constants.SUFFIX_JSON
    static let EDIT_ALBUM: String = versionJsonOnly + "album/edit" + Constants.SUFFIX_JSON
    static let REMOVE_ALBUM: String = versionJsonOnly + "album/remove" + Constants.SUFFIX_JSON
    static let REGISTER_DEVICE: String = versionJson + "refresh/firebase" + Constants.SUFFIX_JSON
    static let GET_LIST_BUS: String = versionJsonOnly + "student/buses" + Constants.SUFFIX_JSON
    static let GET_BUS_DETAIL: String = versionJsonOnly + "student/buses/detail" + Constants.SUFFIX_JSON
    static let GET_REVIEWS: String = versionJson + "review" + Constants.SUFFIX_JSON
    static let REGISTER_EXTRACURRICULAR: String = versionJson + "extracurricular/upsert" + Constants.SUFFIX_JSON
    static let GET_LIST_EXTRACURRICULAR: String = versionJson + "extracurricular" + Constants.SUFFIX_JSON
    static let GET_EXTRACURRICULAR_DETAIL: String = versionJson + "extracurricular/"
    static let GET_SHUTTLE: String = versionJson + "bus-off" + Constants.SUFFIX_JSON
    static let ABSENCE_CREATE: String = versionJson + "absence/create" + Constants.SUFFIX_JSON
    static let ABSENCE_REMOVE: String = versionJson + "absence/remove" + Constants.SUFFIX_JSON
    static let SHUTTLE_CREATE: String = versionJson + "bus-off/add" + Constants.SUFFIX_JSON
    static let SHUTTLE_EDIT: String = versionJson + "bus-off/edit" + Constants.SUFFIX_JSON
    static let SHUTTLE_REMOVE: String = versionJson + "bus-off/delete" + Constants.SUFFIX_JSON
    static let GET_CLASS_DETAIL: String = versionJson + "class" + Constants.SUFFIX_JSON
    static let GET_LIST_FEE: String = versionJson + "fees" + Constants.SUFFIX_JSON
    static let GET_FEE_DETAIL: String = versionJsonOnly + "fee/detail" + Constants.SUFFIX_JSON
    static let GET_CHAT_DETAIL: String = versionJson + "chat-room/detail" + Constants.SUFFIX_JSON
    static let CREATE_SCHEDULE: String = versionJson + "schedule" + Constants.SUFFIX_JSON
    static let CREATE_NOTIFICATION: String = versionJson + "notification" + Constants.SUFFIX_JSON
    static let UPDATE_STATUS_NOTIFICATION: String = versionJsonOnly + "controller/update_noti_status" + Constants.SUFFIX_JSON
    static let LIST_STUDENT: String = versionJson + "list_student" + Constants.SUFFIX_JSON
    static let NEWS: String = versionJson + "news" + Constants.SUFFIX_JSON
    static let LIST_CLASSES: String = versionJson + "class" + Constants.SUFFIX_JSON

}

enum GradiantDirection {
    case leftToRight
    case rightToLeft
    case topToBottom
    case bottomToTop
}

public enum ToastStyle {
    case success
    case danger
    case waring
    case info
    case noti
}

public enum Permission: String {
    case IN_OUT_CLASS = "1"
    case IN_OUT_BUS = "2"
    case ALBUM = "3"
    case MENU = "4"
    case MENU_ONLY_VIEW = "-4"
    case HEALTH = "5"
    case SCHEDULE = "6"
    case SCHEDULE_ONLY_VIEW = "-6"
    case MESSAGE = "7"
    case ABSENCE = "8"
    case ABSENCE_ONLY_VIEW = "-8"
    case REMINDER = "9"
    case REMINDER_ONLY_VIEW = "-9"
    case PEEPOO = "10"
    case PEEPOO_ONLY_VIEW = "-10"
    case BUS_TRACKING = "15"
}

enum PushNotificationType: String {
    case NOTIFICATION = "1"
    case TOPIC = "2"
    case INOUT_BUS = "3"
    case INOUT_CLASS = "4"
    case ALBUM = "5"
    case FEE = "6"
    case ABSENCE = "7"
    case HEALTH = "8"
    case REMINDER = "9"
    case PEE_POO = "10"
    case BUS_OFF = "15"
    case CHAT_ROOM = "20"
    case SURVEY = "22"
}

enum Permission_Menu: String {
    case CHECK_IN = "1"
    case ALBUM = "2"
    case MENU = "3"
    case SCHEDULE = "4"
    case ABSENCE = "5"
    case IN_OUT = "6"
    case MESSAGE = "7"
    case HEALTH = "8"
    case REVIEW = "9"
    case PEEPOO = "10"
    case REMINDER = "11"
    case FEE = "12"
    case CHAT_ROOM_CHECKIN = "13"
    case BUS_TRACKING = "15"
    case SURVEY = "16"
    case COMMENT = "17"
    case EXTRACURRICULAR = "18"
}

enum MENU_PUSH: String {
    case DAILY_EMAIL = "1"
    case WEEKLY_EMAIL = "2"
    case MONTHLY_EMAIL = "3"
    case YEARS_EMAIL = "4"
    case DAILY_APP = "5"
    case WEEKLY_APP = "6"
    case MONTHLY_APP = "7"
    case YEARS_APP = "8"
}

enum KeyPushRemote: String {
    case type = "type"
    case notificationId = "notification_id"
    case classId = "class_id"
    case topicId = "topic_id"
    case busId = "bus_id"
    case reminderId = "reminder_id"
    case relationType = "relation_type"
    case date = "date"
    case monthYear = "month_year"
    case studentId = "student_id"
    case id = "id"
    case billId = "bill_id"
    
    //absence
    case absenceId = "absence_id"
    case absenceStatus = "absence_status"
    case absenceReason = "absence_reason"
    case absenceEndDate = "absence_end_date"
    case absenceStartDate = "absence_start_date"
    case absenceNote = "absence_note"
    case absenceDate = "absence_date"

}

enum ImageViewType {
    case one
    case two
    case three
    case other
}

enum TypeMeal: Int, CaseIterable {
    case breakfast
    case extra_lunch
    case lunch
    case extra_dinner

    var image: UIImage? {
        switch self {
        case .breakfast:
            return #imageLiteral(resourceName: "ic_sunrise")
        case .extra_lunch:
            return #imageLiteral(resourceName: "ic_sunrise2")
        case .lunch:
            return #imageLiteral(resourceName: "ic_sun")
        case .extra_dinner:
            return #imageLiteral(resourceName: "ic_sunset2")
        }
    }
}

enum TypeDay: Int, CaseIterable {
    case morning
    case afternoon
    
    var image: UIImage? {
        switch self {
        case .morning:
            return #imageLiteral(resourceName: "ic_sunrise")
        case .afternoon:
            return #imageLiteral(resourceName: "ic_sunrise2")
        }
    }
}

enum TypeStatus: Int {
    case ignore
    case acceptUpdate
    case viewOnly
    case acceptCreate
    case create
    case update
    
    var text: String {
        switch self {
        case .ignore:
            return "Đã huỷ"
        case .acceptUpdate, .acceptCreate:
            return "Đã duyệt"
        case .viewOnly:
            return ""
        case .create, .update:
            return "Chờ duyệt"
        }
    }
    
    func getTitleColor() -> UIColor {
        switch self {
        case .ignore:
            return .darkGray
        default:
            return .white
        }
    }
    
    func getViewColor() -> UIColor {
        switch self {
        case .create, .update:
            return UIColor.infoColor
        case .acceptUpdate, .acceptCreate:
            return UIColor.successColor
        case .ignore:
            return UIColor.lightGrayColor
        case .viewOnly:
            return .white
        }
    }
}
