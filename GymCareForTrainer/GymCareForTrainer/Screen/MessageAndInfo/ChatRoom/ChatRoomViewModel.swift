//
//  ChatRoomViewModel.swift
//  GymCare
//
//  Created by Truong Nguyen Huu on 15/02/2023.
//

import UIKit

final class ChatRoomViewModel: BaseViewModel {
    
    func getChatDetail(showLoading: Bool, id: Int, completion: @escaping (TopicDetailModel?, String?) -> Void) {
        self.repository.getTopicDetail(showLoading: showLoading, id: id) { data, msg in
            completion(data, msg)
        }
    }

    func getReloadChatDetail(id: Int, time: String, completion: @escaping (TopicDetailModel?, String?) -> Void) {
        self.repository.getReloadChatDetail(id: id, time: time) { data, msg in
            completion(data, msg)
        }
    }

    func sendChatMessage(id: Int, content: String, ins_datetime: String, completion: @escaping (Bool, String?) -> Void) {
        self.repository.chatMessage(id: id, content: content, ins_datetime: ins_datetime) { status, msg in
            completion(status, msg)
        }
    }
    
    func filterDupplicateMessages(messages: [MessageModel]) -> [MessageModel] {
        var buffer = [MessageModel]()
        for message in messages where !buffer.contains(where: {$0.id == message.id}) {
            buffer.append(message)
        }
        return buffer
    }

}
