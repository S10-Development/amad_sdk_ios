//
//  Actions.swift
//  core
//
//  Created by Pablo Jair Angeles on 23/09/24.
//

public struct Actions:Codable ,Sendable{
    var call:String?
    var openWebView:String?
    var openSections: String?
    var showBySchedule: [ShowBySchedule?]
    var showUrlInBrowser: Bool? = false 
}
