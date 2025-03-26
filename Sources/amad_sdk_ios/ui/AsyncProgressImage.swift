//
//  AsyncImage.swift
//  core
//
//  Created by Pablo Jair Angeles on 02/12/24.
//
import SwiftUI

 struct AsyncProgressImage: View {
    let url: String
    
     init(url: String) {
        self.url = url
    }
    
     var body: some View {
        if(url.isEmpty){
            Image(.itemDefault) // Muestra un icono predeterminado en caso de error
                .resizable()
                .scaledToFit()
            
        }else{
            AsyncImage(url: URL(string: url)) { phase in
                switch phase {
                case .empty:
                    ProgressView() // Muestra un indicador de carga
                case .success(let image):
                    image
                        .resizable()
                        .transition(.scale(scale: 0.1, anchor: .center))
                    
                case .failure:
                    Image(.itemDefault) // Muestra un icono predeterminado en caso de error
                        .resizable()
                        .scaledToFit()
                @unknown default:
                    Image(.itemDefault) // Muestra un icono predeterminado en caso de error
                        .resizable()
                        .scaledToFit()
                }
            }
        }

    }
}

