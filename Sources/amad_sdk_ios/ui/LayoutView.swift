//
//  LayoutView.swift
//  core
//
//  Created by Pablo Jair Angeles on 13/10/24.
//


import SwiftUI
 struct LayoutView: View {
    @State var navigateOtherView: Bool = false
     @State var scrollHeigth: CGFloat = Constants.higthWeb.toCGFloat()

    @State private var selectedNewView:String  = Constants.EMPTY_STRING
    @Environment(\.openURL) var openURL
    @StateObject private var viewModel: ApplicationViewModel = ApplicationViewModel()
    @ObservedObject private var layoutViewModel: LayoutViewModel = LayoutViewModel()
     public init(view:ViewComponent) {
         layoutViewModel.view = view

    }
    
     var body: some View {
        NavigationStack {
            Spacer()
            ScrollView{
                GeometryReader { geometry in

                    ForEach(layoutViewModel.view.component, id: \.UUID) { view in
            
                        let scaleWidth: CGFloat = view.properties.size.widthToScale(from: geometry.frame(in: .local).width)
                        let scalelHeight: CGFloat = view.properties.size.heightToScale(from: geometry.frame(in: .local).height)
                        
                        let scaleX: CGFloat = view.properties.position.toXScale(from: geometry.frame(in: .local).width)
                        
                        let scaleY: CGFloat = view.properties.position.toYScale(from: geometry.frame(in: .local).height)
                        
                        let _ = print("======== COMPONENT \(view.UUID) (\(view.type)) ====")
                        let _ = print("geometry->height: \(geometry.frame(in: .local).height)")

                        let _ = print("original Position->x: \(view.properties.position.x), y: \(view.properties.position.y)")
                        let _ = print("original size-> w: \(view.properties.size.width), h: \(view.properties.size.height)")
                        let _ = print("scaleX: \(scaleX), scaleY: \(scaleY), scaleWidth: \(scaleWidth), scalelHeight: \(scalelHeight)")
                        let _ = print("================================================")
                   createView(view)
                            .frame(width: scaleWidth, height: scalelHeight)
                            .offset(x: scaleX, y: scaleY)
                            .onTapGesture {
                                self.clickAction(view)
                            }
                    }
                     
                }.frame(height: self.layoutViewModel.view.properties.height)
                    .background(self.layoutViewModel.view.properties.backgroundColor)
            }
        }
        .navigationDestination(isPresented: $navigateOtherView) {
            if let application = CacheManager.shared.getData(forKey: CacheManager.shared.APPLICATION_KEY, as: AppInformation.self),
               let newView = application.getViewByID(selectedNewView) {
                LayoutView(view: newView)
            } else {
                Text("Vista no encontrada")
            }
        }
    }
    
    private  func createNewView(){
        if let application = CacheManager.shared.getData(forKey: CacheManager.shared.APPLICATION_KEY, as: AppInformation.self),
           let newView = application.getViewByID(selectedNewView) {
            layoutViewModel.view = newView
        } else {
        }
    }
    
    private  func clickAction(_ component: Component) {
        viewModel.sendEvents(event:
            EventAnalytics(id: component.properties.idAnalytics ?? Constants.EMPTY_STRING,
                           otherInformation: component.properties.actionAnalytics ?? Constants.EMPTY_STRING)
        )

        // 1️⃣ Verifica si ya estamos navegando antes de cambiar el estado
        guard !navigateOtherView else { return }

        if let newSection = component.actions?.openSections, !newSection.isEmpty {
            selectedNewView = newSection
            createNewView()
            return
        }

        if let webURLString = component.actions?.openWebView, let url = URL(string: webURLString) {
            UIApplication.shared.open(url)
            return
        }

        if let callNumber = component.actions?.call, !callNumber.isEmpty,
           let url = URL(string: "tel://\(callNumber)") {
            openURL(url)
            return
        }
    }


    
    private func createView(_ view: Component) -> some View {
        switch view.type {
        case TypeComponent.button:
            print("--------View: \(view.type)--------")
            
            return AnyView(ButtonComponent(component: view,onTap: {
                self.clickAction(view)
            }))
        case TypeComponent.carousel:
            print("--------View: \(view.type)--------")
            
            return AnyView(CarouselComponent(component: view))
        case TypeComponent.text:
            print("--------View: \(view.type)--------")
            
            return AnyView(TextComponent(component: view,onTap: {
                self.clickAction(view)
            }))
        case TypeComponent.image:
            print("--------View: \(view.type)--------")
            return AnyView(ImageComponent(component: view,onTap: {
                self.clickAction(view)
            }))
        case TypeComponent.imageButton:
            print("--------View: \(view.type)--------")
            return AnyView(ButtonImageComponent(component: view,onTap: {
                self.clickAction(view)
            }))
        case TypeComponent.video:
            print("--------View: \(view.type)--------")
            return AnyView(VideoComponent(component: view))
        default:
            return AnyView(EmptyView())
        }
    }
}


#Preview {
    LayoutView(view:JsonMock.parseJSON())
}
