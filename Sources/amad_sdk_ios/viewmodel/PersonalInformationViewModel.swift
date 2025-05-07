//
//  PersonalInformationViewModel.swift
//  amad_sdk_ios
//
//  Created by Pablo Jair Angeles on 04/05/25.
//

import Combine
import Foundation
import UIKit
import CoreLocation

class PersonalInformationViewModel: ViewModelBase {
    @Published public var tokenRequestModel:TokenRequestModel = .init()
        
    @Published var selectionLocation: (type: TypeSelected?, location: LocationDropdowItem?) = (
        nil,
        nil
    )
    @Published  var phone: String = Constants.EMPTY_STRING
    @Published  var email: String = Constants.EMPTY_STRING
    @Published  var name: String = Constants.EMPTY_STRING
    @Published  var idApplication: String = Constants.EMPTY_STRING

    override init() {
        self.tokenRequestModel = TokenRequestModel()
        super.init()

        GeolocationService.shared.requestLocation { result in
            switch result {
            case .success(let coord):
                self.tokenRequestModel.otherInformation.lat = coord.latitude
                self.tokenRequestModel.otherInformation.long = coord.longitude
               
            case .failure(_): break
            }
        }
    }

    @MainActor
    func sendPersonalInformation(onChange: @escaping()->Void ) {
        showLoading()
        
        Task { @MainActor in
            self.makeTokenRequest()
            self.performSend(onChange: onChange)
        }
   
    
      
    }
 
    @MainActor
    private func performSend(onChange: @escaping()->Void ){
        SendInformationUseCase().execute(params: tokenRequestModel)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion:makeCompletionError {
                    onChange()
                },
                receiveValue: {  value in
                   onChange()
                }
            )
            .store(in: &subscriptions)
    }
    
    @MainActor
    private func makeTokenRequest(){
        
      

        // 1️⃣ Info de sistema y app
        let device = UIDevice.current
        tokenRequestModel.androidVersion = device.systemVersion
        tokenRequestModel.model          = device.model
        tokenRequestModel.idApplication = idApplication

        // 2️⃣ Teléfono
        tokenRequestModel.phoneNumber = phone
        tokenRequestModel.phoneId     = Constants.EMPTY_STRING

        // 4️⃣ Origin podría ser el bundle identifier
        tokenRequestModel.otherInformation.origin =  Constants.EMPTY_STRING

        // 5️⃣ TelMarc ado (igual a número marcado)
        tokenRequestModel.otherInformation.telMarcado = phone

        // 6️⃣ Según el tipo seleccionado, asignamos estado/municipio/colonia
        if let type = selectionLocation.type,
           let item = selectionLocation.location {
            switch type {
            case .states:
                tokenRequestModel.otherInformation.state = String(item.name)
            case .municipality:
                tokenRequestModel.otherInformation.municipio = String(item.name)
            case .neighborhood:
                tokenRequestModel.otherInformation.colonia = String(item.name)
            }
        }

    }
}

