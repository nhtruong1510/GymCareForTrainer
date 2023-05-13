//
//  MessageViewModel.swift
//  SchoolUpTeacher
//
//  Created by Nguyen Ha on 10/01/2023.
//

import Foundation

final class MessageViewModel: BaseViewModel {

    private var totalTopics = 0
    var page = 1
    
    func getTopics(showLoading: Bool, completion: @escaping (TopicModel?, String?) -> Void) {
        self.repository.getTopics(showLoading: showLoading, customerId: castToInt(ServiceSettings.shared.userInfo?.id)) { data, msg in
            completion(data, msg)
        }
    }

    func loadMore(topics: [TopicDetailModel] = []) -> Bool {
        if topics.count > 0 && topics.count < totalTopics {
            page += 1
            return true
        }
        return false
    }

}
