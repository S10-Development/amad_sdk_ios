//
//  LayoutViewModel.swift
//  core
//
//  Created by Pablo Jair Angeles on 16/02/25.
//

import Combine
import CoreGraphics

 class LayoutViewModel: ViewModelBase{
    
     @Published var view: ViewComponent = createDefaultView()
     
     @MainActor
     func calculateContentRect(for screenSize: CGSize) -> CGSize {
          var maxX: CGFloat = 0
          var maxY: CGFloat = 0

         for view in view.component {
              let width = view.properties.size.widthToScale(from: screenSize.width)
              let height = view.properties.size.heightToScale(from: screenSize.height)

              let x = view.properties.position.toXScale(from: screenSize.width)
              let y = view.properties.position.toYScale(from: screenSize.height)

              maxX = max(maxX, x + width)
              maxY = max(maxY, y + height)
          }

          return CGSize(width: max(maxX, screenSize.width), height: max(maxY, screenSize.height))
      }

}
