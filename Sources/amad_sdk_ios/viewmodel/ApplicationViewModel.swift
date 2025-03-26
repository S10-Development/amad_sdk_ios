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
    @Published public var application: AppInformation = AppInformation(appId: "", views: [], status: 0, preconfiguration: .init())
    
    @Published public var urlAudio: String?
    
     func loadApplication(id: String) {
        showLoading()
        GetApplicationUseCase().execute(params: id)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion:completionError,
                receiveValue: {  value in
                    self.setupData(application: value)
                  
                    //self?.playAudio(application: value)
                    self.hideLoading()

                    print("Loaded application:", value)
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
            .sink(
                receiveCompletion:completionError,
                receiveValue: { _ in
                }
            )
            .store(in: &subscriptions)
    }
    
    
    
    private func saveAudio(application: AppInformation?) {
        guard let application = application else {
            print("No application to save.")
            return
        }
        Task { @MainActor in
            do {
                try await CacheManager.shared.saveData(application, forKey: CacheManager.shared.APPLICATION_KEY)
            } catch {
                print("Failed to save application: \(error.localizedDescription)")
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
                try await CacheManager.shared.saveData(application, forKey: CacheManager.shared.APPLICATION_KEY)
                print("Application saved successfully.")
            } catch {
                print("Failed to save application: \(error.localizedDescription)")
            }
        }
    }
}
