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
    var showLoading: Bool = true

    init(showLoading: Bool) {
        self.showLoading = showLoading
    }
    
    func willSend(_ request: RequestType, target: TargetType) {
        if showLoading {
            CustomProgressHUD.showProgress()
        }
    }

    func didReceive(_ result: Result<Response, MoyaError>, target: TargetType) {
        CustomProgressHUD.dismissProgress()
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

public class NetworkManager {
    var moyaProvider = MoyaProvider<APIRouter>()

    init(showLoading: Bool? = true) {
        moyaProvider = MoyaProvider<APIRouter>(plugins: [NetworkPlugin(showLoading: showLoading!), NetworkLoggerPlugin(configuration: .init(formatter: .init(responseData: JSONResponseDataFormatter), logOptions: .verbose))])
    }
}

enum APIRouter {
    case login(String, String)
    case editProfile(UserModel) 
    case getUser(Int)
    case resetPass(String)
    case updatePass(String, String, String)
    case changePass(String, String, String)
    case getTopics(Int)
    case getTopicDetail(Int)
    case chatMessage(String, String, String)
    case logout
    case getChatDetail(Int, Int)
    case getReloadChatDetail(Int, String)
    case getSchedule(Int)
    case getNotification(Int)
    case createNoti(ScheduleParamObject)
    case createSchedule(ScheduleParamObject)
    case updateSchedule(ScheduleParamObject)
    case updateStatusNoti(Int)
    case listStudent(Int, Int)
    case news
    case classes(Int)

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
        case .editProfile, .getUser: return EndPointURL.USER
        case .resetPass: return EndPointURL.RESET_PASS
        case .updatePass: return EndPointURL.UPDATE_PASS
        case .changePass: return EndPointURL.CHANGE_PASS
        case .getTopics: return EndPointURL.GET_TOPICS
        case .getTopicDetail: return EndPointURL.GET_TOPIC_DETAIL
        case .chatMessage: return EndPointURL.GET_TOPIC_DETAIL
        case .logout: return EndPointURL.LOGOUT
        case .getChatDetail: return EndPointURL.GET_CHAT_DETAIL
        case .getReloadChatDetail: return EndPointURL.RELOAD_CHAT_DETAIL
        case .createSchedule, .getSchedule: return EndPointURL.CREATE_SCHEDULE
        case .getNotification: return EndPointURL.CREATE_NOTIFICATION
        case .createNoti: return EndPointURL.CREATE_NOTIFICATION
        case .updateSchedule: return EndPointURL.CREATE_NOTIFICATION
        case .updateStatusNoti: return EndPointURL.UPDATE_STATUS_NOTIFICATION
        case .listStudent: return EndPointURL.LIST_STUDENT
        case .news: return EndPointURL.NEWS
        case .classes: return EndPointURL.LIST_CLASSES

        }
    }

    var method: Moya.Method {
        switch self {
        case .login, .resetPass, .updatePass, .changePass, .chatMessage, .logout,
                .createNoti, .createSchedule, .updateStatusNoti,
                .editProfile:
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
        case .editProfile(let param):
            var formData = [Moya.MultipartFormData]()
//            let dictionary = param.toDictionary()
//            formData.append(contentsOf: createForm(dictionary: dictionary))
            let dictionary = param.toDictionary()
            let jsonData = try! JSONSerialization.data(withJSONObject: dictionary, options: .prettyPrinted)
            let paramPart = MultipartFormData(provider: .data(jsonData), name: "data")
            formData.append(paramPart)
            if let files = param.avatarFile {
                formData.append(contentsOf: createMultipartFormData(listImage: [files], fileName: "avatarFile"))
            }
            return .uploadMultipart(formData)
        case .getUser(let id):
            return .requestParameters(parameters: ["trainer_id": id], encoding: URLEncoding.queryString)
        case .resetPass(let email):
            return .requestParameters(parameters: ["email": email], encoding: JSONEncoding.default)
        case .updatePass(let pass, let confirmPass, let token):
            return .requestParameters(parameters: ["password": pass, "confirm_password": confirmPass, "token": token], encoding: JSONEncoding.default)
        case .changePass(let pass, let confirmPass, let oldPass):
            return .requestParameters(parameters: ["password": pass, "confirm_password": confirmPass, "old_password": oldPass], encoding: JSONEncoding.default)
        case .getTopics(let trainer_id):
            return .requestParameters(parameters: ["trainer_id": trainer_id], encoding: URLEncoding.queryString)
        case .getTopicDetail(let id):
            return .requestParameters(parameters: ["chat_id": id], encoding: URLEncoding.queryString)
        case .chatMessage(let id, let message, let insDatetime):
            return .requestParameters(parameters: ["chat_id": id, "content": message, "ins_datetime": insDatetime], encoding: JSONEncoding.default)
        case .getChatDetail(let id, let page):
            return .requestParameters(parameters: ["id": id, "page": page], encoding: URLEncoding.queryString)
        case .getReloadChatDetail(let id, let currentDatetime):
            return .requestParameters(parameters: ["chat_id": id, "ins_datetime": currentDatetime], encoding: URLEncoding.queryString)
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
        case .listStudent(let timeId, let isCancelled):
            return .requestParameters(parameters: ["time_id": timeId, "is_cancelled": isCancelled], encoding: URLEncoding.queryString)
        case .classes(let trainer_id):
            return .requestParameters(parameters: ["trainer_id": trainer_id], encoding: URLEncoding.queryString)
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
