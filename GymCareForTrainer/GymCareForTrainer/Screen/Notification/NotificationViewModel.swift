//
//  NotificationViewModel.swift
//  GymCareForTrainer
//
//  Created by Truong Nguyen Huu on 16/03/2023.
//

import Foundation

final class NotificationViewModel: BaseViewModel {

    func callApiGetSchedule(showLoading: Bool, customerId: Int, completion: @escaping (NotificationModel?, String?) -> Void) {
        self.repository.getNotification(showLoading: showLoading, customerId: customerId) { data, msg in
            completion(data, msg)
        }
    }
    
    func callApiUpdateStatus(notiId: Int, completion: @escaping () -> Void) {
        self.repository.updateStatusNoti(notiId: notiId) { data, msg in
            completion()
        }
    }
    
    func getClasses(trainerId: Int, completion: @escaping ([ScheduleClass]?, String?) -> Void) {
        self.repository.getClasses(trainerId: trainerId) { data, msg in
            completion(data, msg)
        }
    }
}
