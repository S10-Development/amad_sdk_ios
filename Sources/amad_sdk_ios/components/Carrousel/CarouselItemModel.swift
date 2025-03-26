//
//  CarouselItemModel.swift
//  Caraousel
//
//  Created by Edo Lorenza on 17/03/24.
//

import SwiftUI

struct CarouselItemModel: Identifiable {
    var id: Int
    var name: String = ""
    var image: String
    
    
    init(itemCarousel:ItemCarousel, id:Int){
        self.id = id
        self.name = itemCarousel.title
        self.image = itemCarousel.src
    }
}
