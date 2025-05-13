//
//  LayoutView.swift
//  core
//
//  Created by Pablo Jair Angeles on 13/10/24.
//


import SwiftUI
import Lottie
struct LayoutView: View {
    @Environment(\.openURL) var openURL
    @StateObject private var viewModel: ApplicationViewModel = ApplicationViewModel()
    @ObservedObject private var layoutViewModel: LayoutViewModel = LayoutViewModel()
    public init(view:ViewComponent) {
        layoutViewModel.sendNewView(viewComponent: view)
    }
    var body: some View {
        VStack{
            if(layoutViewModel.isLoading){
                
                LottieView(animation: .named("loader", bundle: .module))
                    .playing()
                    .looping()
                    .resizable()
                    .frame(width: 150, height: 100)
                    .scaledToFill()
            }else {
                makeHeader()
                makeBody()
                
                Spacer()
                makeFooter()
            }
        }.navigationDestination(isPresented: $layoutViewModel.navigateWebView, destination: {
            CustomWebView(url: layoutViewModel.urlWebView)
        })
        .onAppear(){
            print("Apper")
        }

        
       
    }
    // MARK: - Cuerpo principal de la vista
     /// Genera el contenido desplazable con los componentes escalados y posicionados.
     @ViewBuilder
     func makeBody() -> some View {
         ScrollView {
             GeometryReader { geometry in

                 ForEach(
                     layoutViewModel.view.component,
                     id: \.UUID
                 ) { view in
                     let scaleComponent = makeScaleComponent(
                         for: view,
                         in: geometry,scaleHeigthTo: layoutViewModel.view.properties.height  <  CGFloat(Constants.higthWeb) ? CGFloat(Constants.higthWeb) : layoutViewModel.view.properties.height
                     )
                     createView(
                         view,
                         viewModel,
                         layoutViewModel: layoutViewModel
                     )
                     .frame(
                         width: scaleComponent.width,
                         height: scaleComponent.height
                     )
                     .offset(x: scaleComponent.x, y: scaleComponent.y)
                     .onTapGesture {
                         self.clickAction(view,viewModel, layoutViewModel)
                     }
                 }
             }
             .frame(height: self.layoutViewModel.view.properties.getHeight())
             .background(self.layoutViewModel.view.properties.backgroundColor)

         }
     }
  
    // MARK: - Cuerpo principal de la vista
     /// Genera el contenido desplazable con los componentes escalados y posicionados.
    @ViewBuilder
    func makeFooter() -> some View {
        // Solo dibujamos si footer existe y tiene componentes
        if let components = layoutViewModel.view.footer?.components,
           !components.isEmpty {
            GeometryReader { geometry in
                ForEach(components, id: \.UUID) { view in
                    let scale = makeScaleComponent(
                        for: view,
                        in: geometry,
                        scaleHeigthTo: 100
                    )
                    createView(view, viewModel, layoutViewModel: layoutViewModel)
                        .frame(width: scale.width, height: scale.height)
                        .offset(x: scale.x, y: scale.y)
                        .onTapGesture {
                            clickAction(view, viewModel, layoutViewModel)
                        }
                }
            }
            .frame(height: 100)
        }
    }
    // MARK: - Cuerpo principal de la vista
     /// Genera el contenido desplazable con los componentes escalados y posicionados.
    @ViewBuilder
    func makeHeader() -> some View {
        // Solo dibujamos si header existe y tiene componentes
        if let components = layoutViewModel.view.header?.components,
           !components.isEmpty {
            GeometryReader { geometry in
                ForEach(components, id: \.UUID) { view in
                    let scale = makeScaleComponent(
                        for: view,
                        in: geometry,
                        scaleHeigthTo: 100
                    )
                    createView(view, viewModel, layoutViewModel: layoutViewModel)
                        .frame(width: scale.width, height: scale.height)
                        .offset(x: scale.x, y: scale.y)
                        .onTapGesture {
                            clickAction(view, viewModel, layoutViewModel)
                        }
                }
            }
            .frame(height: 100)
            .background(layoutViewModel.view.properties.backgroundColor)
        }
    }
}



#Preview {
    LayoutView(view:JsonMock.parseJSON())
}
