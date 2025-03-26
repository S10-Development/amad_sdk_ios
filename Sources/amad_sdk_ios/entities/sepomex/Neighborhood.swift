//
//  Neighborhood.swift
//  core
//
//  Created by Pablo Jair Angeles on 17/12/24.
//

// MARK: - Neighborhood
public struct Neighborhood: Codable,Sendable {
    let idColonia: Int
    let colonia: String

    enum CodingKeys: String, CodingKey {
        case idColonia = "id_colonia"
        case colonia
    }
}
