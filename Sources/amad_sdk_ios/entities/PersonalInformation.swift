//
//  PersonalInformation.swift
//  core
//
//  Created by Pablo Jair Angeles on 16/12/24.
//

public struct PersonalInformationModel: Codable,Sendable {
    let showTypesData: [ShowType]
    let locationInformation: LocationInformation?
    let title:String
    let urlImage:String
    var active:Bool? = false
}

public struct ShowType :Codable,Sendable{
let type:PersonalInfoFieldType
let isRequeried:Bool
    
    // Constructor por defecto
      public init(type: PersonalInfoFieldType, isRequeried: Bool) {
          self.type = type
          self.isRequeried = isRequeried
      }
    // Decodificación que admite tanto string como objeto
      public init(from decoder: Decoder) throws {
          // 1) Intentamos decodificar como string
          if let single = try? decoder.singleValueContainer(),
             let raw = try? single.decode(String.self) {
              // Si viene solo "Telefono", lo mapeamos a type y ponemos isRequeried = false
              guard let fieldType = PersonalInfoFieldType(rawValue: raw) else {
                  throw DecodingError.dataCorruptedError(
                      in: single,
                      debugDescription: "Valor '\(raw)' no coincide con ningún PersonalInfoFieldType"
                  )
              }
              self.type = fieldType
              self.isRequeried = false
              return
          }

          // 2) Si no es string, esperamos un objeto con keys
          let container = try decoder.container(keyedBy: CodingKeys.self)
          self.type        = try container.decode(PersonalInfoFieldType.self, forKey: .type)
          self.isRequeried = try container.decode(Bool.self,              forKey: .isRequeried)
      }
}
// MARK: - ShowType (Enum)
public enum PersonalInfoFieldType: String, Codable,Sendable {
    case telefono = "Telefono"
    case correo = "Correo"
    case nombre = "Nombre"
    case localizacion = "Localizacion"
}

// MARK: - LocationInformation
public struct LocationInformation: Codable ,Sendable{
    let neighborhoods: Neighborhood?
    let state: StateResponse?
    let municipality: Municipality?
}






