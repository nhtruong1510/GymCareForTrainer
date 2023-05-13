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

// MARK: - Datum
class ScheduleClass: Codable {
    var datumClass: Class?
    var address: Address?
    var time: [TimeClass]?

    enum CodingKeys: String, CodingKey {
        case datumClass = "class"
        case address, time
    }

    init(datumClass: Class?, address: Address?, time: [TimeClass]?) {
        self.datumClass = datumClass
        self.address = address
        self.time = time
    }
}

// MARK: - Time
class TimeClass: Codable {
    var id: Int?
    var time, date: String?
    var customer: [UserModel]?

    init(id: Int?, time: String?, date: String?, customer: [UserModel]?) {
        self.id = id
        self.time = time
        self.date = date
        self.customer = customer
    }
}
