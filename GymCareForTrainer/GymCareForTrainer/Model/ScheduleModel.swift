//
//  ScheduleModel.swift
//  GymCare
//
//  Created by Truong Nguyen Huu on 11/03/2023.
//

import Foundation

// MARK: - DataClass
class ScheduleModel: Codable {
    var schedules: [Schedule]?

    init(schedules: [Schedule]?) {
        self.schedules = schedules
    }
}

// MARK: - Schedule
class Schedule: Codable {
    var id: Int?
    var date: [DateElementSchedule]?
    var trainer: Trainer?
    var scheduleClass: Class?

    enum CodingKeys: String, CodingKey {
        case id, date, trainer
        case scheduleClass = "class"
    }

    init(id: Int?, date: [DateElementSchedule]?, trainer: Trainer?, scheduleClass: Class?) {
        self.id = id
        self.date = date
        self.trainer = trainer
        self.scheduleClass = scheduleClass
    }
}

class DateSchedule {
    var id: Int?
    var date: [DateElement]?
    var trainer: Trainer?
    var scheduleClass: Class?
}
