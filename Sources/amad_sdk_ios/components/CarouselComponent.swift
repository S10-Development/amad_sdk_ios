//
//  CarouselComponent.swift
//  core
//
//  Created by Pablo Jair Angeles on 29/09/24.
//

import SwiftUI


struct CarouselComponent: View {
    let component:Component
    let timer = Timer.publish(every: 3.0, on: .main, in: .common).autoconnect()
       
       // Step 3: Manage Selected Image Index
       @State private var selectedImageIndex: Int = 0

       var body: some View {
           ZStack {
               TabView(selection: $selectedImageIndex) {
                   // Step 6: Iterate Through Images
                   ForEach(0..<(component.properties.itemCarousel?.count ?? 0), id: \.self) { index in
                       ZStack(alignment: .topLeading) {
                           // Step 7: Display Image
                           AsyncProgressImage(url: (component.properties.itemCarousel?[index].src) ?? Constants.EMPTY_STRING)
     
                       }
                   }
               }
               .background(Color.clear)
               .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never)) // Step 11: Customize TabView Style
               .ignoresSafeArea()
           }
           .onReceive(timer) { _ in
               // Step 16: Auto-Scrolling Logic
               withAnimation(.default) {
                   selectedImageIndex = (selectedImageIndex + 1) % (component.properties.itemCarousel?.count ?? Constants.ZERO)
               }
           }
       }
    
}
