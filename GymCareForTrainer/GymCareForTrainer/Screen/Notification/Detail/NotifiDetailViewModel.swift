//
//  NotifiDetailViewModel.swift
//  AppPit
//
//  Created by Truong Nguyen Huu on 19/08/2022.
//

import Foundation

final class NotifiDetailViewModel: BaseViewModel {
    func createNoti(param: ScheduleParamObject, completion: @escaping (Bool, String?) -> Void) {
        self.repository.createNoti(param: param) { success, msg in
            completion(success, msg)
        }
    }
    
    func createSchedule(param: ScheduleParamObject, completion: @escaping (Bool, String?) -> Void) {
        self.repository.createSchedule(param: param) { success, msg in
            completion(success, msg)
        }
    }
    
    func updateSchedule(param: ScheduleParamObject, completion: @escaping (Bool, String?) -> Void) {
        self.repository.updateSchedule(param: param) { success, msg in
            completion(success, msg)
        }
    }
}
