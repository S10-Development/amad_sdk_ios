//
//  LoadingDialog.swift
//  core
//
//  Created by Pablo Jair Angeles on 04/12/24.
//
import SwiftUI
import Lottie
struct LoadingDialog: View {
    let message: String
    @Binding var isPresented: Bool

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
                    LottieView(animation: .named("loader", bundle: .module))
                        .playing()
                        .looping()
                        .resizable()
                        .frame(width: 150, height: 100)
                        .scaledToFill()
                    Text(message)
                        .foregroundColor(.black)
                        .font(.headline)
                }
                .padding()
                .background(Color.white)
                .cornerRadius(20)
                .shadow(radius: 20)
                .padding(30) // Padding externo para separar la tarjeta del borde de la pantalla
              
            }
            .frame(width: 400) // Ancho de la tarjeta
            
        }
        .transition(.opacity)
    }
}

#Preview {
    VStack{}.showLoadingDialog(Binding.constant(true))
}

struct LoadingDialogModifier: ViewModifier {
    @Binding var isPresented: Bool
    var message: String = Constants.EMPTY_STRING

    func body(content: Content) -> some View {
        ZStack {
            content
            if isPresented {
                LoadingDialog(message: message, isPresented: $isPresented)
                    .edgesIgnoringSafeArea(.all)
            }
        }
    }
}
extension View {
     func showLoadingDialog( _ isPresented: Binding<Bool>, message: String = "Cargando...") -> some View {
        return self.modifier(LoadingDialogModifier(isPresented: isPresented, message:message))
    }
}
