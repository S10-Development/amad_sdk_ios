//
//  GeolocalationService.swift
//  amad_sdk_ios
//
//  Created by Pablo Jair Angeles on 06/05/25.
//

import Foundation
import CoreLocation

/// Administra la geolocalización y devuelve la posición mediante un closure.
final class GeolocationService: NSObject,  @unchecked Sendable{
    
    static let shared = GeolocationService()
    
    private let locationManager = CLLocationManager()
    private var completion: ((Result<CLLocationCoordinate2D, Error>) -> Void)?

    private override init() {
        super.init()
        locationManager.delegate = self
        // Ajusta la precisión según tus necesidades
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    /// Solicita autorización y obtiene la ubicación una sola vez.
      func requestLocation(completion: @escaping (Result<CLLocationCoordinate2D, Error>) -> Void) {
          self.completion = completion
          
          // iOS 14+: usar la instancia; antes de iOS 14, el método static
          let status: CLAuthorizationStatus
          if #available(iOS 14.0, *) {
              status = locationManager.authorizationStatus
          } else {
              status = CLLocationManager.authorizationStatus()
          }
          
          switch status {
          case .notDetermined:
              locationManager.requestWhenInUseAuthorization()
          case .authorizedWhenInUse, .authorizedAlways:
              locationManager.requestLocation()
          case .denied, .restricted:
              completion(.failure(LocationError.authorizationDenied))
          @unknown default:
              completion(.failure(LocationError.unknownAuthorizationStatus))
          }
      }
    
    enum LocationError: LocalizedError {
        case authorizationDenied
        case unableToFetchLocation
        case unknownAuthorizationStatus
        
        var errorDescription: String? {
            switch self {
            case .authorizationDenied:
                return "Permiso de ubicación denegado."
            case .unableToFetchLocation:
                return "No se pudo obtener la ubicación."
            case .unknownAuthorizationStatus:
                return "Estado de autorización desconocido."
            }
        }
    }
}

// MARK: – CLLocationManagerDelegate

extension GeolocationService: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        // Si el usuario acaba de autorizar, le pedimos la ubicación
        if status == .authorizedWhenInUse || status == .authorizedAlways {
            manager.requestLocation()
        } else if status == .denied {
            completion?(.failure(LocationError.authorizationDenied))
            completion = nil
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let coord = locations.first?.coordinate else {
            completion?(.failure(LocationError.unableToFetchLocation))
            completion = nil
            return
        }
        completion?(.success(coord))
        completion = nil
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        completion?(.failure(error))
        completion = nil
    }
}
