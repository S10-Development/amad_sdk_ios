//
//  S10Component.swift
//  amad_sdk_ios
//
//  Created by Pablo Jair Angeles on 06/05/25.
//
import SwiftUI
struct S10Component: View {
    var component:Component
    var onTap: (() -> Void)? // Closure para manejar el clic
    var body: some View {
        HStack{
            Text(self.component.properties.text ?? Constants.EMPTY_STRING)
                .foregroundStyle(
                    Color.init(
                        hex: self.component.properties.colorText ?? Constants.COLOR_TEXT
                    )
                )
                .font(
                    .system(
                        size:CGFloat(
                            self.component.properties.fontSize ?? Constants.FONT_SIZE
                        )
                    )
                )

            
            AsyncProgressImage(
                url: component.properties.base64Image ?? Constants.EMPTY_STRING
            ).frame(
                width: component.properties.imageSize?.widthToCGFloat(),
                height: component.properties.imageSize?.heightToCGFloat()
            )
        }                .frame(
            width: CGFloat(self.component.properties.size.width),
            height: CGFloat(self.component.properties.size.height)
        )
        .background(
            Color.init(
                hex: self.component.properties.background ?? Constants.WHITE_COLOR
            )
        )
        
        .onTapGesture {
            onTap?()
        }
    }
    

}
#Preview {
    @Previewable
    var component:Component =  Component(
        type: .s10plus,
        properties: Properties(
            position: Position(x: 0, y: 0),
            size: SizeComponent(width: 200, height: 100.0),
            text: "Power by",
            itemCarousel: [],
            base64Image: "https://media.s10plus.com/s10plus_20250506_202939.png",
            imageSize : SizeComponent(width: 40,height: 40)
),
        UUID: "",
        actions: nil
    )
    S10Component(component:component)

}
