//
//  PositionAligment.swift
//  core
//
//  Created by Pablo Jair Angeles on 03/02/25.
//

import UIKit
import SwiftUICore

enum PositionAlignment: String,Codable,Sendable {
    case left = "left"
    case bottom = "bottom"
    case right = "right"
    case top = "top"
    
    func toAlignment() -> Alignment {
            switch self {
            case .left: return .leading
            case .bottom: return .bottom
            case .right: return .trailing
            case .top: return .top
            }
        }
}

