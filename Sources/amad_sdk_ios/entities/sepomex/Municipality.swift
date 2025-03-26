//
//  Municipality.swift
//  core
//
//  Created by Pablo Jair Angeles on 17/12/24.
//

// MARK: - Municipality
public struct Municipality: Codable,Sendable {
    let idMunicipio: Int
    let municipio: String

    enum CodingKeys: String, CodingKey {
        case idMunicipio = "id_municipio"
        case municipio
    }
}
