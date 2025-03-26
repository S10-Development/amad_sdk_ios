//
//  ShowBySchedule.swift
//  core
//
//  Created by Pablo Jair Angeles on 08/10/24.
//

// Swift
struct ShowBySchedule: Codable,Sendable {
    enum Day: String, Codable,Sendable {
        case monday = "1"
        case tuesday = "2"
        case wednesday = "3"
        case thursday = "4"
        case friday = "5"
        case saturday = "6"
        case sunday = "7"
    }
    
    let dayStart: Day
    let dayEnd: Day
    let hourStart: String
    let hourEnd: String
    let show: Bool
    
    public init (dayStart: Day, dayEnd: Day, hourStart: String, hourEnd: String, show: Bool) {
        self.dayStart = dayStart
        self.dayEnd = dayEnd
        self.hourStart = hourStart
        self.hourEnd = hourEnd
        self.show = show    
    }
}
