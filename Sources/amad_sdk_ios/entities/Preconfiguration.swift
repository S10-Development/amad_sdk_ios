//
//  Preconfiguration.swift
//  core
//
//  Created by Pablo Jair Angeles on 23/09/24.
//

public struct Preconfiguration :Codable,Sendable{
    var activeGeoLocalization: Bool = false
    var interceptorPhone: [String] = []
    var offline = false
    var showState: Bool = false
    var urlAnalytics: String = ""
    var urlSound: String = ""
    var welcomeVideo:String = ""
}
