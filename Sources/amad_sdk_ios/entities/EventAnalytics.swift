//
//  Event.swift
//  core
//
//  Created by Pablo Jair Angeles on 09/12/24.
//

public struct EventAnalytics: Codable,Sendable {
    let  id: String
    let otherInformation: String
    enum CodingKeys: String, CodingKey {
        case id      = "id_action"
        case otherInformation = "other_information"
    }
}
