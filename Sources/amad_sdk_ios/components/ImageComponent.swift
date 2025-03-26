//
//  SwiftUIView.swift
//  core
//
//  Created by Pablo Jair Angeles on 29/10/24.
//

import SwiftUI

public struct ImageComponent: View {
    var component:Component
    var onTap: (() -> Void)? // Acción al hacer clic en la imagen

    public  var body: some View {
        GeometryReader { geometry in
            
            AsyncProgressImage(url: component.properties.base64Image ?? Constants.EMPTY_STRING)
                .onTapGesture {
                    onTap?()
                }


        }
    }
}


#Preview {
    
    let component:Component =  Component(type: TypeComponent.text, properties: Properties(position: Position(x: 0, y: 0), size: SizeComponent(width: 400, height: 200), text: "Ejemplo 2", itemCarousel: [],base64Image: "https://picsum.photos/200"), UUID: "", actions: nil)
    ImageComponent(component: component)
}
