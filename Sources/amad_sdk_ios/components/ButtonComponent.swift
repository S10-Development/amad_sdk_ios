//
//  SwiftUIView.swift
//  core
//
//  Created by Pablo Jair Angeles on 23/09/24.
//

import SwiftUI

struct ButtonComponent: View {
    var component:Component
    let textContent: String = "Ejemplo de texto dinámico"
    var onTap: (() -> Void)? // Closure para manejar el clic

    @State private var textSize: CGSize = .zero
    @State private var position: CGSize = .zero
    
    var body: some View {
        Button(action: {
            onTap?() // Llama la acción cuando el botón se presiona

        }, label: {
            GeometryReader { proxy in
                ZStack {
                    Text(component.properties.getText())
                        .font(.system(size: component.properties.toFontSizeCGFloat()))
                        .foregroundColor(component.properties.toColor())
                        .frame(width: component.properties.size.width.toCGFloat(),
                                                     height: component.properties.size.height.toCGFloat(),
                               alignment: component.properties.textAlignment?.getAlignment() ?? Alignment.center)
                    
                }.cornerRadius(component.properties.cornerRadius?.toCGFloat() ?? Constants.ZERO_FLOAT)
            }
            
        })
        .background(component.properties.toBackground())
        .clipShape(RoundedRectangle(cornerRadius: component.properties.cornerRadius?.toCGFloat() ?? 10)) // Botón redondeado

        
    }
    
    
    
}

#Preview {
    
    let component = Component(
        type: TypeComponent.button,
        properties: Properties(
            position: Position(x: 0, y: 0),
            size: SizeComponent(width: 150, height: 55),
            text: "Ejemplo 2",
            itemCarousel: []
        ),
        UUID: "",
        actions: nil
    )
    ButtonComponent(component:component)
}
