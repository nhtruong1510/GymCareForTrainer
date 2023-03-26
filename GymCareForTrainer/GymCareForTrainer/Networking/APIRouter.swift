//
//  APIRouter.swift
//  SchoolUpTeacher
//
//  Created by Nguyễn Hà on 27/12/2022.
//

import UIKit
import Moya
import Alamofire

class NetworkPlugin: PluginType {

    func willSend(_ request: RequestType, target: TargetType) {
//        CustomProgressHUD.showProgress()
    }

    func didReceive(_ result: Result<Response, MoyaError>, target: TargetType) {
//        CustomProgressHUD.dismissProgress()
        switch result {
        case .failure(let error):
            switch error {
            case .underlying(let err, _):
                let afError = err as? Alamofire.AFError
                if let urlError = afError?.underlyingError as? URLError {
                    switch urlError.code {
                    case .timedOut: break
//                        AlertVC.show(msg: "Request time out")
                    case .notConnectedToInternet: break
//                        AlertVC.show(msg: "Không có kết nối mạng")
                    default: break
//                        AlertVC.show(msg: "Unmanaged error")
                    }
                }
            default:
                break
            }
            switch error.response?.statusCode {
            case 400: return
            case 401:
//                AlertVC.show(msg: "Token hết hạn")
                ServiceSettings.shared.clearUserInfo()
//                AppDelegate.shared.setRootVC()
            default: break
//                AlertVC.show(msg: "Lỗi liên kết, vui lòng thử lại")
            }
        default:
            break
        }
    }

}

private func JSONResponseDataFormatter(_ data: Data) -> String {
    do {
        let dataAsJSON = try JSONSerialization.jsonObject(with: data)
        let prettyData = try JSONSerialization.data(withJSONObject: dataAsJSON, options: .prettyPrinted)
        return String(data: prettyData, encoding: .utf8) ?? String(data: data, encoding: .utf8) ?? ""
    } catch {
        return String(data: data, encoding: .utf8) ?? ""
    }
}

let NetworkManager = MoyaProvider<APIRouter>(plugins: [NetworkPlugin(), NetworkLoggerPlugin(configuration: .init(formatter: .init(responseData: JSONResponseDataFormatter),logOptions: .verbose))])

enum APIRouter {
    case login(String, String)
    case resetPass(String)
    case updatePass(String, String, String)
    case changePass(String, String, String)
    case getTopics(Int)
    case getTopicDetail(Int)
    case chatMessage(Int, String, UIImage?)
    case logout
    case getChatDetail(Int, Int)
    case getReloadChatDetail(Int, String)
    case sendChatMessage(Int, String, UIImage?)
    case getSchedule(Int)
    case getNotification(Int)
    case createNoti(ScheduleParamObject)
    case createSchedule(ScheduleParamObject)
    case updateSchedule(ScheduleParamObject)
    case updateStatusNoti(Int)

}

extension APIRouter: TargetType {

    var baseURL: URL {
        if let domain = ServiceSettings.shared.demoDomain, !domain.isEmpty {
            return URL(string: domain)!
        }
        return URL(string: EndPointURL.BASE_API_URL)!
    }

    var path: String {
        switch self {
        case .login: return EndPointURL.LOGIN
        case .resetPass: return EndPointURL.RESET_PASS
        case .updatePass: return EndPointURL.UPDATE_PASS
        case .changePass: return EndPointURL.CHANGE_PASS
        case .getTopics: return EndPointURL.GET_TOPICS
        case .getTopicDetail: return EndPointURL.GET_TOPIC_DETAIL
        case .chatMessage: return EndPointURL.CHAT_MESSAGE
        case .logout: return EndPointURL.LOGOUT
        case .getChatDetail: return EndPointURL.GET_CHAT_DETAIL
        case .getReloadChatDetail: return EndPointURL.RELOAD_CHAT_DETAIL
        case .sendChatMessage: return EndPointURL.SEND_CHAT_MESSAGE
        case .createSchedule, .getSchedule: return EndPointURL.CREATE_SCHEDULE
        case .getNotification: return EndPointURL.CREATE_NOTIFICATION
        case .createNoti: return EndPointURL.CREATE_NOTIFICATION
        case .updateSchedule: return EndPointURL.CREATE_NOTIFICATION
        case .updateStatusNoti: return EndPointURL.UPDATE_STATUS_NOTIFICATION

        }
    }

    var method: Moya.Method {
        switch self {
        case .login, .resetPass, .updatePass, .changePass, .chatMessage, .logout, .sendChatMessage,
                .createNoti, .createSchedule, .updateStatusNoti:
            return .post
        case .updateSchedule:
            return .put
        default:
            return .get
        }
    }

    var task: Task {
        switch self {
        case .login(let email, let pass):
            return .requestParameters(parameters: ["phone": email, "password": pass], encoding: JSONEncoding.default)
        case .resetPass(let email):
            return .requestParameters(parameters: ["email": email], encoding: JSONEncoding.default)
        case .updatePass(let pass, let confirmPass, let token):
            return .requestParameters(parameters: ["password": pass, "confirm_password": confirmPass, "token": token], encoding: JSONEncoding.default)
        case .changePass(let pass, let confirmPass, let oldPass):
            return .requestParameters(parameters: ["password": pass, "confirm_password": confirmPass, "old_password": oldPass], encoding: JSONEncoding.default)
        case .getTopics(let page):
            return .requestParameters(parameters: ["page": page], encoding: URLEncoding.queryString)
        case .getTopicDetail(let id):
            return .requestParameters(parameters: ["topic_id": id], encoding: URLEncoding.queryString)
        case .chatMessage(let id, let message, let image):
            let formData = getDataChatMessage(id: id, message: message, image: image)
            return .uploadMultipart(formData)
        case .getChatDetail(let id, let page):
            return .requestParameters(parameters: ["id": id, "page": page], encoding: URLEncoding.queryString)
        case .getReloadChatDetail(let id, let currentDatetime):
            return .requestParameters(parameters: ["id": id, "current_datetime": currentDatetime], encoding: URLEncoding.queryString)
        case .sendChatMessage(let id, let message, let image):
            let formData = getDataChatMessage(id: id, message: message, image: image, idName: "id")
            return .uploadMultipart(formData)
        case .getSchedule(let trainerId):
            return .requestParameters(parameters: ["trainer_id": trainerId], encoding: URLEncoding.queryString)
        case .getNotification(let trainerId):
            return .requestParameters(parameters: ["trainer_id": trainerId], encoding: URLEncoding.queryString)
        case .createSchedule(let param), .updateSchedule(let param):
            return .requestParameters(parameters: param.toDictionary(), encoding: JSONEncoding.default)
        case .createNoti(let param):
            return .requestParameters(parameters: param.toDictionary(), encoding: JSONEncoding.default)
        case .updateStatusNoti(let notiId):
            return .requestParameters(parameters: ["notification_id": notiId], encoding: JSONEncoding.default)
        default:
            return .requestPlain
        }
    }

    var headers: [String : String]? {
        switch self {
        case .login:
            return ["Content-Type": "application/json"]
        default:
            return ["Content-Type": "application/json",
                    "Authorization": getAuthorizationHeader()]
        }
    }

    var validationType: ValidationType {
        return .successCodes
    }
    
    private func getAuthorizationHeader() -> String {
        if let accessToken = ServiceSettings.shared.accessToken {
            return "Bearer " + accessToken
        }
        return ""
    }
}
