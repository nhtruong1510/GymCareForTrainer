//
//  OtherViewModel.swift
//  GymCare
//
//

import Foundation

final class OtherViewModel: BaseViewModel {
    
    func callApiLogout(completion: @escaping (Bool, String?) -> Void) {
        self.repository.logout { status, msg in
            completion(status, msg)
        }
    }
}
