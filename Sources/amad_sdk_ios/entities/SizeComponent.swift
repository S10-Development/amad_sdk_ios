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
    
    @MainActor public func widthToScale(from:CGFloat,scaleTo:CGFloat = CGFloat(Constants.widthWeb)) -> CGFloat {
        let scaleWidth = (CGFloat(width) * from) / scaleTo
        return scaleWidth
    }
    
    @MainActor public func heightToScale(from:CGFloat,scaleTo:CGFloat = CGFloat(Constants.higthWeb)) -> CGFloat {
        let scaleHeight = (CGFloat(height) * from) / scaleTo
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

