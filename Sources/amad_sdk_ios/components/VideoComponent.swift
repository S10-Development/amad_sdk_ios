//
//  VideoComponent.swift
//  core
//
//  Created by Pablo Jair Angeles on 03/02/25.
//

import SwiftUI
import AVKit

struct VideoComponent: View {
    var component:Component

    var body: some View {
        if let url = URL(string: component.properties.videoURL ?? Constants.EMPTY_STRING) {
            VideoPlayer(player: AVPlayer(url: url))
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.black)
                .onAppear {
                    print("VideoComponent -> Playing video from URL: \(String(describing: component.properties.videoURL))")
                }
        } else {
            Text("video no Valido")
                .foregroundColor(.red)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.black)
        }
    }
}

#Preview {
    @Previewable
    var component:Component =  Component(type: TypeComponent.text, properties: Properties(position: Position(x: 0, y: 0), size: SizeComponent(width: 100.0, height: 100.0), text: "Ejemplo 2", itemCarousel: []), UUID: "", actions: nil)
    VideoComponent(component: component)
}
