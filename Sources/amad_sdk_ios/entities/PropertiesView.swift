//
//  PropertiesView.swift
//  amad_sdk_ios
//
//  Created by Pablo Jair Angeles on 05/04/25.
//


import SwiftUI

public struct PropertiesView: Codable,Sendable {
    let background: String
    let width: CGFloat
    let scrollable: Bool
    let height: CGFloat
    
    public init(
        background: String,
        width: CGFloat,
        scrollable: Bool,
        height: CGFloat
    ) {
        self.background = background
        self.width = width
        self.scrollable = scrollable
        self.height = height
    }
    // Propiedad adicional para convertir background a Color de SwiftUI
    var backgroundColor: Color {
        Color(hex: background)
    }
    
    public func getHeight() -> CGFloat {
        let minimumHeight = CGFloat(Constants.higthWeb)
        return max(height, minimumHeight)
    }
    
    public static let defaultProperties = PropertiesView(
            background: "#FFFFFF",
            width: 0,
            scrollable: false,
            height: CGFloat(Constants.higthWeb)
        )
}

