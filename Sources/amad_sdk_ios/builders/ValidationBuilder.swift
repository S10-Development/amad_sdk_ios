//
//  ValidationBuilder.swift
//  amad_sdk_ios
//
//  Created by Pablo Jair Angeles on 06/05/25.
//

import Foundation


/// Builder para componer varias reglas de validación.
struct ValidationBuilder {
    private var rules: [ValidationRule] = []
    
    /// El campo no puede estar vacío (opción equivalente a “isRequired”).
    @discardableResult
    mutating func required(_ message: String = "Este campo es obligatorio.") -> Self {
        rules.append(.init(
            validate: { !$0.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty },
            message: message
        ))
        return self
    }
    
    /// Validación por expresión regular.
    @discardableResult
    mutating func regex(
        _ pattern: String,
        message: String
    ) -> Self {
        rules.append(.init(
            validate: {
                NSPredicate(format: "SELF MATCHES %@", pattern)
                    .evaluate(with: $0.trimmingCharacters(in: .whitespacesAndNewlines))
            },
            message: message
        ))
        return self
    }
    
    /// Regla personalizada.
    @discardableResult
    mutating func custom(
        _ validate: @escaping (String) -> Bool,
        message: String
    ) -> Self {
        rules.append(.init(validate: validate, message: message))
        return self
    }
    /// Valida que el texto sea un nombre: sólo letras y espacios, con longitud mínima.
       @discardableResult
       mutating func name(minLength: Int = 2,
                          message: String = "El nombre debe tener sólo letras y al menos 2 caracteres.") -> Self {
           let pattern = "^[A-Za-zÁÉÍÓÚáéíóúÑñ ]{\(minLength),}$"
           return regex(pattern, message: message)
       }
       
       /// Valida que el texto sea un teléfono de exactamente n dígitos.
       @discardableResult
    mutating func phone(
        length: Int = 10,
        message: String = ""
    ) -> Self {
        let defaultMessage = "El teléfono debe contener sólo \(length) dígitos."
        let fmtMessage = message.isEmpty ? defaultMessage : message
        let pattern = "^[0-9]{\(length)}$"
        return regex(pattern, message: fmtMessage)
    }
       
       /// Valida que el texto tenga formato de correo básico.
       @discardableResult
       mutating func email(
           message: String = "Introduce un correo válido (ejemplo@dominio.com)."
       ) -> Self {
           let pattern = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
           return regex(pattern, message: message)
       }
    
    // <-- Cambiado de fileprivate a interno (por defecto)
      func build() -> [ValidationRule] {
          rules
      }
}
