//
//  UserModel.swift
//  GymCare
//
//  Created by Truong Nguyen Huu on 06/03/2023.
//

import Foundation
import UIKit

// MARK: - DataClass
class TrainerModel: Codable {
    var rowsReturned: Int?
    var trainer: [Trainer]?

    enum CodingKeys: String, CodingKey {
        case rowsReturned = "rows_returned"
        case trainer
    }
}

// MARK: - Trainer
class Trainer: Codable {
    var id: Int?
    var name, email, phone: String?
    var avatar, birth, address: String?
    var gender: Int?
    var certificate, experience, workplace, specialize: String?
}

// MARK: - UserModel
class UserModel: Codable {
    var id: Int?
    var name, phone, email: String?
    var avatar: String?
    var address: String?
    var gender: Int?
    var birth: String?
    var avatarFile: UIImage?
    var password: String?
    var isCancelled: String?

    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case email
        case birth
        case gender
        case avatar
        case phone
        case address
        case isCancelled = "is_cancelled"
    }
    
    init(id: Int?, name: String?, phone: String?, email: String?,
         avatar: String?, address: String?, gender: Int?, birth: String?) {
        self.id = id
        self.name = name
        self.phone = phone
        self.email = email
        self.avatar = avatar
        self.address = address
        self.gender = gender
        self.birth = birth
    }
    
    init() {}
    
    func toDictionary() -> [String: Any] {
        var dictionary = [String: Any]()
        dictionary.updateValue(castToString(name), forKey: "name")
        dictionary.updateValue(castToString(phone), forKey: "phone")
        dictionary.updateValue(castToString(password), forKey: "password")
        return dictionary
    }
}
