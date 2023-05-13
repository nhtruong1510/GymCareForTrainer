//
//  ScheduleViewModel.swift
//  GymCare
//
//  Created by Truong Nguyen Huu on 11/03/2023.
//

import Foundation

final class ScheduleViewModel: BaseViewModel {

    private var schedules: [Schedule]?
    var dateElements: [DateElementSchedule] = []

    func callApiGetSchedule(showLoading: Bool, customerId: Int, completion: @escaping (String?) -> Void) {
        self.repository.getSchedule(showLoading: showLoading, customerId: customerId) { data, msg in
            if let msg = msg {
                completion(msg)
            } else {
                if let data = data {
                    self.schedules = data.schedules
                    self.dateElements = self.getDateElements()
                    completion(nil)
                }
            }
//            completion(data, msg)
        }
    }
    
    private func getDateElements() -> [DateElementSchedule] {
        var dateElement: [DateElementSchedule] = []
        guard let schedules = schedules else { return [] }
        for schedule in schedules {
            guard let dates = schedule.date else { return [] }
            for date in dates {
                dateElement.append(date)
            }
        }
        return dateElement
    }
    
    func getAllTimeElement(date: String?) -> [Time] {
        var times: [Time] = []
        for dateElement in getDateElements() where date == dateElement.date {
            guard let time = dateElement.time else { continue }
            let dupplicateTimes = times.firstIndex(where: {$0.address == time.address && $0.className == time.className && $0.time == time.time})
            if let dupplicateTimes = dupplicateTimes {
                times[dupplicateTimes].ids.append((castToInt(time.id), castToInt(time.isCancelled)))
            } else {
                time.ids.append((castToInt(time.id), castToInt(time.isCancelled)))
                times.append(time)
            }
        }
        let futureTimes = times.filter({castToString($0.date).formatToDate(Constants.DATE_PARAM_FORMAT) >= Date()})
        if futureTimes.count > 0 {
            var listNextSchedule: [Time] = [futureTimes[0]]
            if futureTimes.count > 1 {
                listNextSchedule.append(futureTimes[1])
            }
            ServiceSettings.shared.listLastestSchedule = listNextSchedule
        }
        return times
    }
}
