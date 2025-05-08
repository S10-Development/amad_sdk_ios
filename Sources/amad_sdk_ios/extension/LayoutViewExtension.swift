//
//  LayoutViewExtension.swift
//  amad_sdk_ios
//
//  Created by Pablo Jair Angeles on 29/04/25.
//

import SwiftUICore
import SwiftUI


extension LayoutView {
    
    /// Calcula los factores de escala para un componente dado, basándose
    /// en el tamaño y posición del `GeometryProxy`.
    ///
    /// - Parameters:
    ///   - component: El componente con sus propiedades de tamaño y posición.
    ///   - proxy: El `GeometryProxy` que provee el frame de referencia.
    /// - Returns: Un `ScaleComponent` con los factores de escala en ancho, alto y posición.
    func makeScaleComponent(for component: Component, in proxy: GeometryProxy,scaleHeigthTo:CGFloat = CGFloat(Constants.widthWeb)) -> ScaleComponent {
        // Extraemos el frame local sólo una vez
        let frame = proxy.frame(in: .local)
        let width = frame.width
        let height = frame.height
        
        // Calculamos escalas de tamaño
        let scaleWidth  = component.properties.size.widthToScale(from: width)
        let scaleHeight = component.properties.size.heightToScale(from: height,scaleTo:scaleHeigthTo)
        
        // Calculamos escalas de posición
        let scaleX = component.properties.position.toXScale(from: width)
        let scaleY = component.properties.position.toYScale(from: height)
        
        print("======== COMPONENT \(component.UUID) (\(component.type)) ====")
        print("geometry->height: \(proxy.frame(in: .local).height)")
        
        print(
            "original Position->x: \(component.properties.position.x), y: \(component.properties.position.y)"
        )
        print(
            "original size-> w: \(component.properties.size.width), h: \(component.properties.size.height)"
        )
        print(
            "scaleX: \(scaleX), scaleY: \(scaleY), scaleWidth: \(scaleWidth), scalelHeight: \(scaleHeight)"
        )
        print("================================================")
        
        return ScaleComponent(
            width:  scaleWidth,
            height: scaleHeight,
            x:      scaleX,
            y:      scaleY
        )
    }
    
    func createView(_ view: Component,_ viewModel: ApplicationViewModel,layoutViewModel: LayoutViewModel) -> some View {
        switch view.type {
        case .button:
            return AnyView(
                ButtonComponent(
                    component: view,
                    onTap: { clickAction(view,viewModel,layoutViewModel)
                    })
            )
        case .carousel:
            return AnyView(CarouselComponent(component: view))
        case .text:
            return AnyView(
                TextComponent(
                    component: view,
                    onTap: { clickAction(view,viewModel,layoutViewModel)
                    })
            )
        case .image:
            return AnyView(
                ImageComponent(
                    component: view,
                    onTap: { clickAction(view,viewModel,layoutViewModel)
                    })
            )
        case .imageButton:
            return AnyView(
                ButtonImageComponent(
                    component: view,
                    onTap: { clickAction(view,viewModel,layoutViewModel)
                    })
            )
        case .video:
            return AnyView(VideoComponent(component: view))
        case .s10plus:
            return AnyView(S10Component(component: view))
        default:
            return AnyView(EmptyView())
        }
    }
    
    // MARK: - Manejo de la acción de tap en un componente
    func clickAction(_ component: Component,
                     _ viewModel: ApplicationViewModel,
                     _ layoutViewModel: LayoutViewModel,
                     onSelectedNewView: Binding<String>? = nil) {
        viewModel.sendEvents(event:
                                EventAnalytics(
                                    id: component.properties.idAnalytics ?? Constants.EMPTY_STRING,
                                    otherInformation: component.properties.actionAnalytics ?? Constants.EMPTY_STRING
                                )
        )
        if let newSection = component.actions?.openSections, !newSection.isEmpty {
            showView(viewID: newSection, in: layoutViewModel)
            return
        }
        
        if let webURLString = component.actions?.openWebView,
           let url = URL(string: webURLString) {
            UIApplication.shared.open(url)
            return
        }
        
        if let callNumber = component.actions?.call, !callNumber.isEmpty,
           let url = URL(string: "tel://\(callNumber)") {
            openURL(url)
            return
        }
    }
    
    /// Carga en el LayoutViewModel la vista cuyo ID coincide con `viewID`.
    ///
    /// - Parameters:
    ///   - viewID: Identificador de la vista a mostrar. Por defecto `Constants.EMPTY_STRING`.
    ///   - viewModel: Instancia de `LayoutViewModel` que será actualizada.
    private func showView(
        viewID: String = Constants.EMPTY_STRING,
        in viewModel: LayoutViewModel
    ) {
        // 1. Obtenemos la AppInformation y la nueva vista en un sólo guard
        guard
            let appInfo: AppInformation = CacheManager
                .shared
                .getData(
                    forKey: CacheManager.shared.APPLICATION_KEY,
                    as: AppInformation.self
                ),
            let newView = appInfo.getViewByID(viewID)
        else {
            // Si falla cualquiera de los dos pasos, salimos sin hacer nada
            return
        }        
        
        // 2. Asignamos la nueva vista
        viewModel.sendNewView(viewComponent: newView)

      
    }

}
