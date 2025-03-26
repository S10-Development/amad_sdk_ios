//
//  ViewModelBase.swift
//  core
//
//  Created by Pablo Jair Angeles on 08/10/24.
//

import Combine
import Foundation
open class ViewModelBase: ObservableObject {
    @Published public var isLoading: Bool = false
    @Published public var showedError: Bool = false
    @Published public var showedSuccess: Bool = false
    @Published public var dialogInformation: DialogInformation = DialogInformation()
    
    public var subscriptions: Set<AnyCancellable> = Set<AnyCancellable>()
    
    public init(){}
    public func hideLoading() {
                Just(false)
                    .delay(for: .seconds(1), scheduler: DispatchQueue.global())
                    .receive(on: DispatchQueue.main) // Asegura que la actualización sea en el hilo principal
                    .assign(to: &$isLoading)
    }
    public func showLoading() {
                Just(true)
                    .delay(for: .seconds(0), scheduler: DispatchQueue.global())
                    .receive(on: DispatchQueue.main) // Asegura que la actualización sea en el hilo principal
                    .assign(to: &$isLoading)
    }
    public func showError(dialogInformation: DialogInformation = DialogInformation()) {
        Just(dialogInformation)
        .delay(for: .seconds(1), scheduler: DispatchQueue.global())
        .receive(on: DispatchQueue.main) // Asegura que la actualización sea en el hilo principal
        .assign(to: &$dialogInformation)
        Just(true)
        .delay(for: .seconds(1), scheduler: DispatchQueue.global())
        .receive(on: DispatchQueue.main) // Asegura que la actualización sea en el hilo principal
        .assign(to: &$showedError)
        
    }
    public func hideError() {
                Just(false)
                    .delay(for: .seconds(1), scheduler: DispatchQueue.global())
                    .receive(on: DispatchQueue.main) // Asegura que la actualización sea en el hilo principal
                    .assign(to: &$showedError)
    }
    
    public func showSuccess(dialogInformation: DialogInformation = DialogInformation()) {
        Just(dialogInformation)
        .delay(for: .seconds(1), scheduler: DispatchQueue.global())
        .receive(on: DispatchQueue.main) // Asegura que la actualización sea en el hilo principal
        .assign(to: &$dialogInformation)
        Just(true)
        .delay(for: .seconds(1), scheduler: DispatchQueue.global())
        .receive(on: DispatchQueue.main) // Asegura que la actualización sea en el hilo principal
        .assign(to: &$showedSuccess)
        
    }
    public func hideSuccess() {
                Just(false)
                    .delay(for: .seconds(1), scheduler: DispatchQueue.global())
                    .receive(on: DispatchQueue.main) // Asegura que la actualización sea en el hilo principal
                    .assign(to: &$showedSuccess)
    }
    public func restartApp(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            NotificationCenter.default.post(name: .restartApp, object: nil)
        }
    }
    
    public func closeSession(){
        CacheManager.shared.clearData(forKey: CacheManager.shared.APPLICATION_SESION)
        SessionManager.shared.clearSession()
        restartApp()
    }
    
    public lazy var completionError:((Subscribers.Completion<APIError>)->Void) = {
        [weak self] completion in
        self?.hideLoading()
        guard let self else { return }
        switch completion {
        case .finished:
            print("Creating user completed.")

            break
        case .failure(let error):
            print("Error request: \(error)")

            // Extraemos el mensaje del error (si es necesario)
                   let errorMessage: String
                   switch error {
                   case .networkError(let networkError):
                       errorMessage = networkError.localizedDescription
                   case .httpError(let statusCode):
                       errorMessage = "HTTP Error: \(statusCode), se requiere iniciar sesión nuevamente."
                   case .serverError(_, let data):
                       errorMessage = "Server Error: \(String(describing: data))"
                   case .decodingError(let decodingError):
                       errorMessage = decodingError.localizedDescription
                   default:
                       errorMessage = "An unknown error occurred."
                   }
            self.showError(dialogInformation: DialogInformation(
                title: "Error",
                message: errorMessage,onClickButton1: {
                    self.closeSession()

                }))
            self.hideLoading()
        }
    }
}
