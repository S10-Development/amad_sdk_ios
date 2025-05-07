//
//  LocationDropdownView.swift
//  core
//
//  Created by Pablo Jair Angeles on 17/12/24.
//

import SwiftUI

// MARK: - LocationDropdownView
struct LocationDropdownView: View {
    @StateObject private var viewModel = SepomexViewModel()
    @Binding var locationInfo: LocationInformation

    @State private var typeSelected:TypeSelected = .states
    @State private var isExpanded: Bool = false
    @State private var selectedOption: LocationDropdowItem = .init(
        name: "Selecciona un estado",
        id: 0
    )

    let isRequired: Bool
    var onValidation: (Bool) -> Void
    var onSelectedType: (TypeSelected,LocationDropdowItem) -> Void

    // Inicializador con default para isRequired y onValidation
    init(
        locationInfo: Binding<LocationInformation>,
        isRequired: Bool = false,
        onValidation: @escaping (Bool) -> Void = { _ in },
        onSelectedType: @escaping (TypeSelected,LocationDropdowItem) -> Void = {_,_ in}
    ) {
        self._locationInfo = locationInfo
        self.isRequired = isRequired
        self.onValidation = onValidation
        self.onSelectedType = onSelectedType
    }

    // Validez: si no es requerido siempre true, si es requerido id != 0
    private var isValid: Bool {
        !isRequired || selectedOption.id != 0
    }

    var body: some View {
        DisclosureGroup(selectedOption.name, isExpanded: $isExpanded) {
            VStack {
                if viewModel.isLoading {
                    ProgressView()
                } else {
                    ForEach(viewModel.items, id: \.id) { option in
                        Text(option.name)
                            .padding()
                            .onTapGesture {
                                selectedOption = option
                                isExpanded = false

                                // Aquí podrías actualizar tu binding locationInfo,
                                // por ejemplo:
                                // locationInfo.state = SelectedState(...)
                                
                                // Y avisamos al padre de la nueva validez
                                onSelectedType(typeSelected, option)
                                onValidation(isValid)
                            }
                    }
                }
            }
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(8)
        // Carga inicial de datos
        .onAppear {
            // Mantén tu lógica actual de viewModel:
            if let state = locationInfo.state {
                viewModel.getMunicipality(id: state.idEstado)
                self.typeSelected = .municipality
            } else if let muni = locationInfo.municipality {
                viewModel.getNeighborhood(id: muni.idMunicipio)
                self.typeSelected = .neighborhood

            } else {
                viewModel.getStates()
                self.typeSelected = .states

            }

            // Informe inicial de validez
            onValidation(isValid)
        }
        .onChange(of: selectedOption.id) { oldId, newId in
            onValidation(isValid)
        }
    }
}


public struct LocationDropdowItem:Equatable{
    let name: String
    let id: Int
}

public enum TypeSelected{
    case neighborhood
    case municipality
    case states
}
