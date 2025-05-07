//
//  Properties.swift
//  core
//
//  Created by Pablo Jair Angeles on 23/09/24.
//

import CoreFoundation
import SwiftUICore

struct Properties :Codable,Sendable {
    var position: Position
    var size: SizeComponent
    var text:String? = ""
    var imageSize:SizeComponent? = nil
    var positionImage:PositionAlignment? = nil
    var cornerRadius: Int? =  nil
    var fontSize:Int? = nil
    var itemCarousel: Array<ItemCarousel>? = []
    var base64Image: String? = nil
    var margin: Margin? = nil
    var urlImage: String? = nil
    var videoURL: String? = nil
    var background: String? = Constants.BACKGROUND_COLOR
    var colorText: String? = Constants.COLOR_TEXT
    var textAlignment: TextAligmentComponent? = TextAligmentComponent.MC
    var idAnalytics:String? = nil
    var actionAnalytics:String? = nil
    init(position: Position, size: SizeComponent, text: String,itemCarousel: Array<ItemCarousel>) {
        self.position = position
        self.size = size
        self.text = text
        self.itemCarousel = itemCarousel
        
    }
    init(position: Position, size: SizeComponent, text: String,itemCarousel: Array<ItemCarousel>,base64Image:String,imageSize:SizeComponent? = nil) {
        self.position = position
        self.size = size
        self.text = text
        self.itemCarousel = itemCarousel
        self.base64Image = base64Image
        self.imageSize = imageSize
        
    }
    
    public func toBackground() -> Color {
        return Color.init(hex: self.background ?? Constants.BACKGROUND_COLOR)
    }
    public func getText() -> String {
        return self.text ?? Constants.EMPTY_STRING
    }
    public func toColor() -> Color {
        return Color.init(hex: self.colorText ?? Constants.COLOR_TEXT)
    }
    public func toFontSizeCGFloat() -> CGFloat {
        return CGFloat(self.fontSize ?? Constants.FONT_SIZE)
    }
    
   public  func itemCarouselToItemCarousel() -> Array<CarouselItemModel> {
        
       
       return self.itemCarousel?.enumerated().map { index, item in
           CarouselItemModel(itemCarousel: item, id: index)
       } ?? []        
    }
}
