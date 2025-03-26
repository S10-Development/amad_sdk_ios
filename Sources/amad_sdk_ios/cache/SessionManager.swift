//
//  SessionManager.swift
//  core
//
//  Created by Pablo Jair Angeles on 10/02/25.
//

import JWTDecode
import Foundation

public final class SessionManager: @unchecked Sendable {
    
    // Instancia Singleton
    public static let shared = SessionManager()

    // Clave para almacenamiento en caché
    private let TOKEN_KEY = "USER_TOKEN"

    // Propiedad privada para el JWT
    private var jwt: JWT?
    private var isAnonymous: Bool = false
    
    private var isDemo = false

    public func setDemo(isDemo:Bool)  {
        self.isDemo = isDemo
    }
    public func getDemo() -> Bool {
        return self.isDemo
    }
    // Constructor privado para evitar instancias externas
    private init() {
        loadSession() // Cargar token al iniciar
    }

    /// Inicia sesión con un token JWT y lo almacena
    public func startSession(by token: String) {
        CacheManager.shared.saveData(token, forKey: TOKEN_KEY)
        decodeToken(token)
        isAnonymous = false 
    }
    public func setAnonymous(isAnonymous:Bool)  {
        self.isAnonymous = isAnonymous
    }
    public func getAnonimous() -> Bool {
        return self.isAnonymous
    }

    /// Obtiene el ID del usuario desde el JWT
    public func getUserId() -> String {
        return jwt?.claim(name: "id_usuario").string ?? ""
    }

    /// Obtiene el nombre completo del usuario desde el JWT
    public func getName() -> String {
        return jwt?.claim(name: "fullUserName").string ?? ""
    }

    /// Verifica si el token es válido y no ha expirado
    public func isSessionValid() -> Bool {
        return jwt?.expired == false
    }

    /// Obtiene el tiempo restante en segundos antes de que el JWT expire
    public func getSessionTimeRemaining() -> TimeInterval? {
        guard let expDate = jwt?.expiresAt else { return nil }
        return expDate.timeIntervalSinceNow > 0 ? expDate.timeIntervalSinceNow : 0
    }

    /// Obtiene la fecha exacta de expiración del JWT
    public func getSessionExpirationDate() -> Date? {
        return jwt?.expiresAt
    }

    /// Cierra sesión eliminando el token
    public func clearSession() {
        jwt = nil
        CacheManager.shared.clearData(forKey: TOKEN_KEY)
    }

    // MARK: - Métodos Privados

    /// Carga el token guardado al iniciar la app
    private func loadSession() {
        if let cachedToken: String = CacheManager.shared.getData(forKey: TOKEN_KEY, as: String.self) {
            decodeToken(cachedToken)
        }
    }

    /// Decodifica el JWT y lo almacena
    private func decodeToken(_ token: String) {
        do {
            self.jwt = try decode(jwt: token)
        } catch {
            self.jwt = nil
            print("❌ Error al decodificar JWT: \(error.localizedDescription)")
        }
    }
}
