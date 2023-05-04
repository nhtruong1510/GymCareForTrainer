//
//  ProgramViewModel.swift
//  GymCareForTrainer
//
//  Created by Truong Nguyen Huu on 23/04/2023.
//

import Foundation

final class ProgramViewModel: BaseViewModel {

    private var schedules: [Schedule]?
    var dateElements: [DateElementSchedule] = []

    func getListStudent(timeId: Int, isCancelled: Int, completion: @escaping (UserModel?, String?) -> Void) {
        self.repository.getListStudent(timeId: timeId, isCancelled: isCancelled) { data, msg in
            completion(data, msg)
        }
    }
}
