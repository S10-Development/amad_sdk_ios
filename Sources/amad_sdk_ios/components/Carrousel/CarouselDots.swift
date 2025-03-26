//
//  CarouselDots.swift
//  core
//
//  Created by Pablo Jair Angeles on 02/10/24.
//

import SwiftUI

struct CarouselDots: View {
    @StateObject private var carouselVM = CarouselViewModel()
    var component:Component
    
    var body: some View {
        VStack(spacing: 10) {
            Spacer()
            CarouselView(items: component.properties.itemCarouselToItemCarousel())
                .environmentObject(carouselVM.stateModel)
            
     
           
        }
        .frame(width: CGFloat(self.component.properties.size.width), height: CGFloat(self.component.properties.size.height))
    }
}

#Preview {
    @Previewable  var component:Component =  Component(
        type: TypeComponent.carousel,
        properties: Properties(
            position: Position(x: 0, y: 0),
            size: SizeComponent(width: 100.0,height: 100.0),
            text: "Ejemplo 2", itemCarousel: [
                ItemCarousel(id: "1", title: "IMAGE", src: "https://loremflickr.com/200/200?random=2"),
                ItemCarousel(id: "2", title: "IMAGE", src: "https://loremflickr.com/200/200?random=4"),
                ItemCarousel(id:"3", title: "IMAGE", src: "https://loremflickr.com/200/200?random=1"),
                ItemCarousel(id: "4", title: "IMAGE", src: "https://loremflickr.com/200/200?random=1"),
            ]),
        UUID: "", actions: nil)
    CarouselDots(component: component)
}
