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

    var  idApplication: String
    var isDemo:Bool = false
    public init(idApplication: String,isDemo:Bool = false) {
        self.idApplication = idApplication
        SessionManager.shared.setDemo(isDemo: isDemo)
    }
    public var body: some View {
       
        NavigationStack{
            HStack{
                if (viewmodel.application.personalInformation?.active ?? false ) {
                    PersonalInfoView(personalInformation: viewmodel.application.personalInformation,fisrtPage: viewmodel.application.getFirstView())
                }else{
                    LayoutView(views: viewmodel.application.getFirstView())
                        .ShowVideoDialogDialog(
                                $isVideoDialogShown,  // Se pasa como Binding
                                by: viewmodel.application.preconfiguration.welcomeVideo
                            )

                }
            }
            .showLoadingDialog($viewmodel.isLoading)
            .onAppear() {
                viewmodel.loadApplication(id: idApplication)
            }.onChange(of: viewmodel.urlAudio){
                let _ = print(viewmodel.urlAudio ?? "NIL")
                if(viewmodel.urlAudio != nil){
                    audioPlayer.playAudio(from: viewmodel.urlAudio!)
                }
            }.onChange(of: viewmodel.application.preconfiguration.welcomeVideo ){
                isVideoDialogShown = viewmodel.application.preconfiguration.welcomeVideo.isNotEmpty()

            }
            .navigationBarBackButtonHidden(true) // Oculta el botón "Back" por defecto
        }
     
    }
}
#Preview {
    MainView(idApplication: "34")
}
