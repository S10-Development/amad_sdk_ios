//
//  SwiftUIView.swift
//  core
//
//  Created by Pablo Jair Angeles on 31/10/24.
//

import SwiftUI

public struct MainView: View {
    @StateObject var viewmodel = ApplicationViewModel()
    @StateObject private var audioPlayer = AudioPlayer()
    @Environment(\.dismiss) var dismiss
    @State private var isVideoDialogShown: Bool = false
    @State private var showLayout: Bool = false

    var  idApplication: String
    var isDemo:Bool = false
    public init(idApplication: String,isDemo:Bool = false) {
        self.idApplication = idApplication
        SessionManager.shared.setDemo(isDemo: isDemo)
    }
    public var body: some View {
       
        NavigationStack{
            HStack{
         
                if viewmodel.application.personalInformation?.active == true && !showLayout {
                    PersonalInfoView(
                        personalInformation: viewmodel.application.personalInformation,
                        fisrtPage: viewmodel.application.getFirstView(),
                        idApplication: self.idApplication
                    ){
                        viewmodel
                            .sendEvents(
                                event: EventAnalytics(
                                    id: viewmodel.application.preconfiguration.tagAnalyticOpen ?? Constants.EMPTY_STRING,
                                    otherInformation: "Opened"
                                )
                            )
                        withAnimation {
                            showLayout = true
                        }
                    }
                }else{
               
                    LayoutView(view: viewmodel.application.getFirstView())
                        .ShowVideoDialogDialog(
                            $isVideoDialogShown,  // Se pasa como Binding
                            by: viewmodel.application.preconfiguration.welcomeVideo
                        )
                }
         
                
            }
            .showLoadingDialog($viewmodel.isLoading)
            .onAppear() {
                viewmodel.loadApplication(id: idApplication){
                    if(
                        !(
                            viewmodel.application.personalInformation?.active ?? false
                        ) == true
                    ){
                        viewmodel.application.appId = self.idApplication
                        viewmodel.sendPersonalInformation {
                            viewmodel
                                .sendEvents(
                                    event: EventAnalytics(
                                        id: viewmodel.application.preconfiguration.tagAnalyticOpen  ?? Constants.EMPTY_STRING,
                                        otherInformation: "Opened"
                                    )
                                )
                        }
                    
                    }
                }
            }.onChange(of: viewmodel.urlAudio){
                let _ = print(viewmodel.urlAudio ?? "NIL")
                if(viewmodel.urlAudio != nil){
                    audioPlayer.playAudio(from: viewmodel.urlAudio!)
                }
            }.onChange(
                of: viewmodel.application.preconfiguration.welcomeVideo
            ){
                isVideoDialogShown = viewmodel.application.preconfiguration.welcomeVideo
                    .isNotEmpty()
            }
        }
     
    }
}
#Preview {
    MainView(idApplication: "7")
}
