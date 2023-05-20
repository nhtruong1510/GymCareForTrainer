//
//  TopicDetailModel.swift
//  GymCare
//
//

import Foundation

// MARK: - DataClass
struct TopicDetailModel: Codable {
    var messages: [MessageModel]?
}

class MessageModel: Codable {

    var id: Int?
    var content: String?
    var is_customer: Int?
    var image: String?
    var insDatetime: String?

    enum CodingKeys: String, CodingKey {
        case id, content
        case is_customer
        case image
        case insDatetime = "ins_datetime"
    }

    func isCustomer() -> Bool {
        return is_customer == 1
    }

}
