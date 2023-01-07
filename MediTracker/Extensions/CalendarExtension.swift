//
//  CalendarExtension.swift
//  MediTracker
//
//  Created by Kanishk Vijaywargiya on 07/01/23.
//

import SwiftUI

extension Calendar {
    /// - Returns 24 hours in a day
    var hours: [Date] {
        //when we get the start of the day, which means 0:00, with the help of this we can retrieve 24 hour dates
        let startOfDay = self.startOfDay(for: Date())
        var hours: [Date] = []
        
        for index in 0..<24 {
            if let date = self.date(byAdding: .hour, value: index, to: startOfDay) {
                hours.append(date)
            }
        }
        return hours
    }
    
    /// - Returns current week in Array format
    var currentWeek: [WeekDay] {
        guard let firstWeekDay = self.dateInterval(of: .weekOfMonth, for: Date())?.start else { return [] }
        
        var week: [WeekDay] = []
        
        for index in 0..<7 {
            if let day = self.date(byAdding: .day, value: index, to: firstWeekDay) {
                /// - EEEE returns the weekday symbol (eg. Monday) from the given date
                let weekDaySymbol: String = day.toString("EEEE")
                let isToday = self.isDateInToday(day)
                week.append(.init(string: weekDaySymbol, date: day, isToday: isToday))
            }
        }//logic is to retrieve week's first day and with the calendar's adding method, we're getting the subsequent 7 dates from the start date
        
        return week
    }
    
    /// - used to store date of each week day
    struct WeekDay: Identifiable {
        var id: UUID = .init()
        var string: String
        var date: Date
        var isToday: Bool = false
    }//with the help of this we can store & iterate over week days using ForEach method
}
