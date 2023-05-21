//
//  HomeViewModel.swift
//  GymCare
//
//

import Foundation

class HomeViewModel: BaseViewModel {

    func callApiGetNews(completion: @escaping ([NewsModel]?, String?) -> Void) {
        self.repository.getNews { data, msg in
            completion(data, msg)
        }
    }
    
    func callApiGetTop(completion: @escaping (TopResponse?, String?) -> Void) {
//        self.repository.callApiGetTopInfo { data, msg in
//            completion(data, msg)
//        }
    }
}
