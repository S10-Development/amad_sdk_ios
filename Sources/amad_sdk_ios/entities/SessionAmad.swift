//
//  Session.swift
//  core
//
//  Created by Pablo Jair Angeles on 10/02/25.
//


public struct SessionAmad: Codable, Sendable {
    public let userId: String
    public let token: String
    public let name:String
    
    public init(userId: String, token: String,name:String) {
        self.userId = userId
        self.token = token
        self.name = name
    }
    public init(token:String){
        self.token = token
        self.userId = ""
        self.name = ""
    }
}
