//
//  StateResponse.swift
//  core
//
//  Created by Pablo Jair Angeles on 17/12/24.
//

// MARK: - State
public struct StateResponse: Codable,Sendable {
    let idEstado: Int
    let estado: String

    enum CodingKeys: String, CodingKey {
        case idEstado = "id_estado"
        case estado
    }
}
