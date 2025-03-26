//
//  ErrorDialog.swiftx
//  core
//
//  Created by Pablo Jair Angeles on 06/03/25.
//


import SwiftUI
import Lottie
import AVKit

struct VideoDialog: View {
    @Binding var isPresented: Bool
    @State var url:String = Constants.EMPTY_STRING

    var body: some View {
        ZStack {
                  Color.black.opacity(0.4) // Fondo oscuro para el modal
                      .edgesIgnoringSafeArea(.all)
                      .onTapGesture {
                          withAnimation {
                              isPresented = false // Cerrar el diálogo si el fondo es tocado
                          }
                      }

                  VStack {
                      VStack {
                        
                          if let url = URL(string:url) {
                              VideoPlayer(player: AVPlayer(url: url))
                          } else {
                              Text("No se cargo el video correctamente")
                                  .foregroundColor(.red)
                          }
                      }
                      .frame(width:300, height:200)
                      .padding()
                      .background(Color.white)
                      .cornerRadius(20)
                      .shadow(radius: 20)
                      .padding(30) // Padding externo para separar la tarjeta del borde de la pantalla
                  }

              }
              .transition(.opacity) // Efecto de transición
    }
}

struct VideoDialog_Previews: PreviewProvider {
    static var previews: some View {
        VStack{}.ShowVideoDialogDialog(Binding.constant(true), by: "")
    }
}
struct VideoDialogModifier: ViewModifier {
    @Binding var isPresented: Bool
    var url: String

    func body(content: Content) -> some View {
        ZStack {
            content
            if isPresented {
                VideoDialog(isPresented: $isPresented, url: url)
                    .edgesIgnoringSafeArea(.all)
            }
        }
    }
}
extension View {
    public func ShowVideoDialogDialog(
        _ isPresented: Binding<Bool>,
        by url:String = Constants.EMPTY_STRING
    ) -> some View {
        self.modifier(VideoDialogModifier(isPresented: isPresented, url: url))
    }
}
