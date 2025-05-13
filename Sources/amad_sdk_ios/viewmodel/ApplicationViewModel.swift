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

class ApplicationViewModel: ViewModelBase {
    @Published public var application: AppInformation = AppInformation(
        appId: "",
        views: [],
        status: 0,
        preconfiguration: .init()
    )
      var tokenRequestModel:TokenRequestModel = .init()

    @Published public var urlAudio: String?
    
     
    func loadApplication(id: String,onFinishLoad: @escaping () -> Void) {
        showLoading()
        GetApplicationUseCase().execute(params: id)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion:completionError,
                receiveValue: {  value in
                    self.setupData(application: value)
                  
                    self.playAudio(application: value)
                    self.hideLoading()
                    onFinishLoad()
                }
            )
            .store(in: &subscriptions)
    }
    
    public func setupData(application: AppInformation) {
        self.application = application
        self.saveApplication(application: application)
    }
    public func sendEvents(event:EventAnalytics) {
        SendAnalyticsUseCase().execute(params: event)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion:{_ in},
                receiveValue: { _ in
                }
            )
            .store(in: &subscriptions)
    }
    
    @MainActor
    func sendPersonalInformation(onChange: @escaping()->Void ) {
        
        GeolocationService.shared.requestLocation { result in
            switch result {
            case .success(let coord):
                self.tokenRequestModel.otherInformation.lat = coord.latitude
                self.tokenRequestModel.otherInformation.long = coord.longitude
                self.makeTokenRequest()
                self.performSend(onChange: onChange)
            case .failure(_): break
            }
        }
     
   
    
      
    }
    private func performSend(onChange: @escaping()->Void ){
        SendInformationUseCase().execute(params: tokenRequestModel)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion:{_ in
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
        tokenRequestModel.idApplication = self.application.appId ?? Constants.EMPTY_STRING

        // 2️⃣ Teléfono
        tokenRequestModel.phoneNumber = Constants.EMPTY_STRING
        tokenRequestModel.phoneId     = Constants.EMPTY_STRING

        // 4️⃣ Origin podría ser el bundle identifier
        tokenRequestModel.otherInformation.origin =  Constants.EMPTY_STRING

        // 5️⃣ TelMarc ado (igual a número marcado)
        tokenRequestModel.otherInformation.telMarcado = Constants.EMPTY_STRING


    }
    private func saveAudio(application: AppInformation?) {
        guard let application = application else {
            print("No application to save.")
            return
        }
        Task { @MainActor in
            do {
                try await CacheManager.shared
                    .saveData(
                        application,
                        forKey: CacheManager.shared.APPLICATION_KEY
                    )
            } catch {
                print(
                    "Failed to save application: \(error.localizedDescription)"
                )
            }
        }
    }
    
    public func playAudio(application: AppInformation?){
        guard let urlSound = application?.preconfiguration.urlSound else {
            print("No sound application to save.")
            return
        }

        self.urlAudio = urlSound
    }
    
    public func saveApplication(application: AppInformation?) {
        guard let application = application else {
            print("No application to save.")
            return
        }
        
        Task { @MainActor in
            do {
                try await CacheManager.shared
                    .saveData(
                        application,
                        forKey: CacheManager.shared.APPLICATION_KEY
                    )
                print("Application saved successfully.")
            } catch {
                print(
                    "Failed to save application: \(error.localizedDescription)"
                )
            }
        }
    }
}
