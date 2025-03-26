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

// MARK: - ShowType (Enum)
public enum ShowType: String, Codable,Sendable {
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






