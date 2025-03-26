//
//  LocationDropdownView.swift
//  core
//
//  Created by Pablo Jair Angeles on 17/12/24.
//

import SwiftUI
 struct LocationDropdownView: View {
    @StateObject var viewmodel = SepomexViewModel()
    @State private var isExpanded: Bool = false
    @State private var selectedOption: LocationDropdowItem = .init(name: "Selecciona un estado", id: 0)
    @Binding var  locationInfo: LocationInformation
    
       var body: some View {
          DisclosureGroup(selectedOption.name, isExpanded: $isExpanded) {
          VStack {
              
              if(viewmodel.isLoading){
                  ProgressView()

              }else{
                  ForEach(viewmodel.items, id: \.id) { option in
                      Text(option.name)
                          .padding()
                          .onTapGesture {
                              selectedOption = option
                              isExpanded = false
                          }
                  }
              }
          }
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(8)
        .onAppear() {
            let _ = print(locationInfo)
            if(locationInfo.state != nil){
                viewmodel.getMunicipality(id: locationInfo.state!.idEstado)
            }else if (locationInfo.municipality == nil){
                viewmodel.getNeighborhood(id: locationInfo.municipality!.idMunicipio)
            }
            else{
                viewmodel.getStates()

            }
        }
      }
}


public struct LocationDropdowItem{
let name: String
let id: Int
}
