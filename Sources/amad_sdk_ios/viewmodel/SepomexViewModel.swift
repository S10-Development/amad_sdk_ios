//
//  ApplicationViewModel.swift
//  core
//
//  Created by Pablo Jair Angeles on 08/10/24.
//

import Combine
import Foundation
import UIKit
import AVFoundation

 class SepomexViewModel: ViewModelBase {
    @Published public var states:[StateResponse] = []
    @Published public var municipality:[Municipality] = []
    @Published public var neighborhood:[Neighborhood] = []
    @Published public var items:[LocationDropdowItem] = []
    func getStates(){
        showLoading()
        GetStatesUseCase()
            .execute(params: nil)
            .sink(
                receiveCompletion:completionError,
                receiveValue: {  value in
                    self.hideLoading()
                    self.states = value
                    self.items = value.map { .init(name: $0.estado, id: $0.idEstado) }
                }
            )
            .store(in: &subscriptions)
    }
    
    func getNeighborhood(id:Int){
        showLoading()
        GetNeighborhoodUseCase()
            .execute(params: id)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion:completionError,
                receiveValue: {  value in
                    self.hideLoading()

                    self.neighborhood = value
                    self.items = value.map { .init(name: $0.colonia, id: $0.idColonia) }
                }
            )
            .store(in: &subscriptions)
    }
    
    func getMunicipality(id:Int){
        GetMunicipalityUseCase()
            .execute(params: id)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion:completionError,
                receiveValue: {
                    value in
                    self.hideLoading()
                    self.municipality = value
                    self.items = value.map { .init(name: $0.municipio, id: $0.idMunicipio) }

                }
            )
            .store(in: &subscriptions)
    }
}
