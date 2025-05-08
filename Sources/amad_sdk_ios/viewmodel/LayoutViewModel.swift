//
//  LayoutViewModel.swift
//  core
//
//  Created by Pablo Jair Angeles on 16/02/25.
//

import Foundation
import Combine

/// ViewModelBase es la clase base de tu arquitectura MVVM
class LayoutViewModel: ViewModelBase {
    // MARK: - Propiedades de navegación
    @Published var view: ViewComponent = createDefaultView()
    @Published var navigateOtherView: Bool = false
    
    // MARK: - Countdown
    @Published var remainingSeconds: Int = 0
    private var timerCancellable: AnyCancellable?
    
    /// Inicia un countdown de `seconds` segundos y llama al closure `onFinish` al terminar.
    /// - Parameters:
    ///   - seconds: Duración inicial del countdown.
    ///   - onFinish: Closure que se ejecuta cuando el countdown llega a 0.
    func startCountdown(seconds: Int, onFinish: @escaping () -> Void = {}) {
        // Reiniciar valor
        remainingSeconds = seconds
        // Cancelar anterior si existía
        timerCancellable?.cancel()

        // Crear publisher de timer que emite cada segundo
        timerCancellable = Timer
            .publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self = self else { return }
                if self.remainingSeconds > 0 {
                    self.remainingSeconds -= 1
                } else {
                    // Cuando llega a cero, cancelar timer y ejecutar closure
                    stopCountdown()
                    onFinish()
                }
            }
    }
    
    /// Detiene el countdown actual.
    func stopCountdown() {
        timerCancellable?.cancel()
        timerCancellable = nil
    }
    
    // MARK: - Métodos de navegación

    /// Cambia la vista actual y resetea navegación
    func sendNewView(viewComponent: ViewComponent) {
        showLoading()
               
        self.hideLoading()
        self.view = viewComponent

      
    }
}
