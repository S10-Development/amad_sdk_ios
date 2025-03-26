//
//  ErrorDialog.swiftx
//  core
//
//  Created by Pablo Jair Angeles on 06/03/25.
//


import SwiftUI
import Lottie

struct SuccessDialog: View {
    @Binding var isPresented: Bool
    @State var dialogInformation:DialogInformation = DialogInformation(title: "Todo correcto",message: "Todo fue la información fue correcta")

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

                          LottieView(animation: .named("success", bundle: .module))
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

struct SuccessDialog_Previews: PreviewProvider {
    static var previews: some View {
        VStack{}.showSuccessDialog(Binding.constant(true), by: DialogInformation(title: "Correcto",message: "Ejemplo de success"))
    }
}
struct SuccessDialogModifier: ViewModifier {
    @Binding var isPresented: Bool
    var dialogInformation: DialogInformation

    func body(content: Content) -> some View {
        ZStack {
            content
            if isPresented {
                SuccessDialog(isPresented: $isPresented, dialogInformation: dialogInformation)
                    .edgesIgnoringSafeArea(.all)
            }
        }
    }
}
extension View {
    public func showSuccessDialog(
        _ isPresented: Binding<Bool>,
        by dialogInformation: DialogInformation = DialogInformation(title: "Todo fue correcto", message: "Ejemplo de success")
    ) -> some View {
        self.modifier(SuccessDialogModifier(isPresented: isPresented, dialogInformation: dialogInformation))
    }
}
