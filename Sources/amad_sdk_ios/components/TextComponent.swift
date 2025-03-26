//
//  TextComponent.swift
//  core
//
//  Created by Pablo Jair Angeles on 24/09/24.
//

import SwiftUI

struct TextComponent: View {
    var component:Component
    var onTap: (() -> Void)? // Closure para manejar el clic
    var body: some View {
        Text(self.component.properties.text ?? Constants.EMPTY_STRING)
            .foregroundStyle(Color.init(hex: self.component.properties.colorText ?? Constants.COLOR_TEXT))
            .font(.system(size:CGFloat(self.component.properties.fontSize ?? Constants.FONT_SIZE)) )
            .frame(width: CGFloat(self.component.properties.size.width), height: CGFloat(self.component.properties.size.height))
            .background(Color.init(hex: self.component.properties.background ?? Constants.WHITE_COLOR))
            .onTapGesture {
                onTap?()
            }

        let _ = print("TextComponent-> \(self.component.properties)")
    }
    

}
#Preview {
    @Previewable
    var component:Component =  Component(type: TypeComponent.text, properties: Properties(position: Position(x: 0, y: 0), size: SizeComponent(width: 100.0, height: 100.0), text: "Ejemplo 2", itemCarousel: []), UUID: "", actions: nil)
    TextComponent(component:component)

}
