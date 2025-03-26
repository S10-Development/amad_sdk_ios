//
//  View.swift
//  core
//
//  Created by Pablo Jair Angeles on 23/09/24.
//

public struct ViewComponent :Codable,Sendable{
    let id: String
    let mainView: Bool
    let nameView: String
    let component: [Component]
}
