//
//  ErrorDialog.swiftx
//  core
//
//  Created by Pablo Jair Angeles on 06/03/25.
//


import SwiftUI
import Lottie

struct ErrorDialog: View {
    @Binding var isPresented: Bool
    @State var dialogInformation:DialogInformation = DialogInformation(title: "Ocurrió un error",message: "Contacte al administrador del sistema")

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
                          Text(dialogInformation.title)
                              .font(.title)
                              .fontWeight(.bold)
                              .foregroundColor(.black)
                              .padding(.bottom, 10)

                          Text(dialogInformation.message)
                              .font(.body)
                              .foregroundColor(.black)
                              .multilineTextAlignment(.center)
                              .padding(.bottom, 20)

                          LottieView(animation: .named("error", bundle: .module))
                              .playing()
                              .looping()
                              .resizable()
                              .frame(width: 120, height: 120)
                              .scaledToFill()
                 
                          Button(action: {
                              withAnimation {
                                  isPresented = false
                                  dialogInformation.onClickButton1?()
                              }
                          }) {
                              Text("Cerrar")
                                  .fontWeight(.bold)
                                  .padding()
                                  .frame(maxWidth: .infinity)
                                  .foregroundColor(.black)
                                  .cornerRadius(10)
                          }
                      }
                      .padding()
                      .background(Color.white)
                      .cornerRadius(20)
                      .shadow(radius: 20)
                      .padding(30) // Padding externo para separar la tarjeta del borde de la pantalla
                  }
                  .frame(width: 400) // Ancho de la tarjeta
              }
              .transition(.opacity) // Efecto de transición
    }
}

struct ErrorDialog_Previews: PreviewProvider {
    static var previews: some View {
        VStack{}.showErrorDialog(Binding.constant(true), by: DialogInformation(title: "ERROR",message: "Ejemplo de error"))
    }
}
struct ErrorDialogModifier: ViewModifier {
    @Binding var isPresented: Bool
    var dialogInformation: DialogInformation

    func body(content: Content) -> some View {
        ZStack {
            content
            if isPresented {
                ErrorDialog(isPresented: $isPresented, dialogInformation: dialogInformation)
                    .edgesIgnoringSafeArea(.all)
            }
        }
    }
}
extension View {
    public func showErrorDialog(
        _ isPresented: Binding<Bool>,
        by dialogInformation: DialogInformation = DialogInformation(title: "ERROR", message: "Ejemplo de error")
    ) -> some View {
        self.modifier(ErrorDialogModifier(isPresented: isPresented, dialogInformation: dialogInformation))
    }
}
