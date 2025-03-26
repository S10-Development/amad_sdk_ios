//
//  CacheManager.swift
//  core
//
//  Created by Pablo Jair Angeles on 13/10/24.
//

import Foundation

import Foundation

 final class CacheManager:@unchecked Sendable {
     public  static let shared = CacheManager()

    // Serial queue para proteger el acceso concurrente.
    private let queue = DispatchQueue(label: "com.example.CacheManager", attributes: .concurrent)

    public let APPLICATION_KEY = "APPLICATION_KEY"
    public let APPLICATION_SESION = "APPLICATION_SESION"
    public let SOUND_KEY = "SOUND_KEY"

    private init() {}

    public func saveData<T: Codable & Sendable>(_ data: T, forKey key: String) {
        queue.async(flags: .barrier) {
            let encoder = JSONEncoder()
            if let encodedData = try? encoder.encode(data) {
                UserDefaults.standard.set(encodedData, forKey: key)
            }
        }
    }

    public func getData<T: Codable>(forKey key: String, as type: T.Type) -> T? {
        return queue.sync {
            guard let data = UserDefaults.standard.data(forKey: key) else { return nil }
            let decoder = JSONDecoder()
            return try? decoder.decode(type, from: data)
        }
    }

    public func clearData(forKey key: String) {
        queue.async(flags: .barrier) {
            UserDefaults.standard.removeObject(forKey: key)
        }
    }
}

