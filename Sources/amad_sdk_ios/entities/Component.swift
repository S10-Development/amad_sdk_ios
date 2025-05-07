//
//  Component.swift
//  core
//
//  Created by Pablo Jair Angeles on 23/09/24.
//

 struct Component :Codable,Sendable{
    let type: TypeComponent
    var properties: Properties
    let UUID: String
    let actions: Actions?
}


public enum TypeComponent: Int, Codable,Sendable {
    case image = 0
    case button = 1
    case imageButton = 2
    case text = 3
    case carousel = 4
    case dialog = 5
    case video = 6
    case s10plus = 8

    case unknown = 999
}
