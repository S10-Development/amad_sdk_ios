//
//  EndPoints.swift
//  core
//
//  Created by Pablo Jair Angeles on 07/10/24.
//


public enum EndPoints {
    case APPLICATION_SERVICES(id:String)
    case LOAD
    case SEND_CLICK
    
    var value: String {
        switch self {
        case .APPLICATION_SERVICES(id: let id):
            return "rest/action/layout/\(id)"
        case .LOAD:
            return "rest/action/load"
        case .SEND_CLICK:
            return "rest/action/click"
        }
    }
}
