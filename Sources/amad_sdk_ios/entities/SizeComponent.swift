//
//  Size.swift
//  core
//
//  Created by Pablo Jair Angeles on 23/09/24.
//

import CoreGraphics
import UIKit


struct SizeComponent :Codable,Sendable{
    var width:Float = 0.0
    var height:Float = 0.0
    
    init (width:Float = 0.0, height:Float = 0.0) {
        self.width = width
        self.height = height
    }
    
    public func widthToCGFloat() -> CGFloat {
        return CGFloat(width)
    }
    
    public func heightToCGFloat() -> CGFloat {
        return CGFloat(height)
    }
    
    @MainActor public func widthToScale(from:CGFloat ) -> CGFloat {
        let scaleWidth = (CGFloat(width) * from) / CGFloat(Constants.widthWeb)
        return scaleWidth
    }
    
    @MainActor public func heightToScale(from:CGFloat) -> CGFloat {
        let scaleHeight = (CGFloat(height) * from) / CGFloat(Constants.higthWeb)
        return scaleHeight
    }
    @MainActor public func widthToScaleCGFloat() -> CGFloat {
        let scaleWidth = (CGFloat(width) * UIScreen.main.bounds.width) / CGFloat(Constants.widthWeb)
        return scaleWidth
    }
    
    @MainActor public func heightToScaleCGFloat() -> CGFloat {
        let scaleHeight = (CGFloat(height) * UIScreen.main.bounds.height) / CGFloat(Constants.widthWeb)
        return scaleHeight
    }
}

