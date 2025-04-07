//
//  Position.swift
//  core
//
//  Created by Pablo Jair Angeles on 23/09/24.
//

import SwiftUICore
import UIKit
struct Position :Codable,Sendable{
    let x:Float
    let y:Float
    
    init (x:Float = 0.0, y:Float = 0.0) {
        self.x = x
        self.y = y
    }
    
    
    
    
    @MainActor func toYCGFloat()->CGFloat{
        return CGFloat(y+1)
    }
    
    @MainActor func toXScale(from:CGFloat)->CGFloat{
        let scale = (CGFloat(x) * from) / CGFloat(Constants.widthWeb)
        return scale
    }
    
    
    @MainActor func toYScale(from:CGFloat)->CGFloat{
        let scale = (CGFloat(y) * from) / from
        return scale
    }
    
    @MainActor func toXCGFloat()->CGFloat{
        return CGFloat(x)
    }
    
    @MainActor func toAdaptiveXScreenWidth(geometryProxy:GeometryProxy)->CGFloat{
        
        let scaleWidth = CGFloat(x) / UIScreen.main.scale
        return CGFloat(scaleWidth)
    }
    @MainActor func toAdaptiveYScreenHeigth(geometryProxy:GeometryProxy)->CGFloat{
        return CGFloat(y)
    }
}
