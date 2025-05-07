//
//  TokenRequestModel.swift
//  amad_sdk_ios
//
//  Created by Pablo Jair Angeles on 04/05/25.
//

import Foundation

// MARK: - TokenRequestModel
public struct TokenRequestModel: Codable {
    var androidVersion: String
    var idApplication: String
    var model: String
    var otherInformation: OtherInformation
    var phoneId: String
    var phoneNumber: String

    enum CodingKeys: String, CodingKey {
        case androidVersion   = "android_version"
        case idApplication    = "id_application"
        case model
        case otherInformation = "other_information"
        case phoneId          = "phone_id"
        case phoneNumber      = "phone_number"
    }
    
    init() {
        androidVersion = Constants.EMPTY_STRING
        idApplication  = Constants.EMPTY_STRING
        model          = Constants.EMPTY_STRING
        otherInformation = .init()
        phoneId         = Constants.EMPTY_STRING
        phoneNumber     = Constants.EMPTY_STRING
        
    }
}

// MARK: - OtherInformation
public struct OtherInformation: Codable {
    var lat: Double
    var long: Double
    var origin: String
    var state: String
    var colonia: String
    var municipio: String
    var telMarcado: String
    
    public init() {
        lat        = Constants.ZERO_DOUBLE
        long       = Constants.ZERO_DOUBLE
        origin     = Constants.EMPTY_STRING
        state      = Constants.EMPTY_STRING
        colonia    = Constants.EMPTY_STRING
        municipio  = Constants.EMPTY_STRING
        telMarcado = Constants.EMPTY_STRING
    }

    enum CodingKeys: String, CodingKey {
        case lat
        case long
        case origin
        case state
        case colonia
        case municipio
        case telMarcado = "telMarcado"
    }
}
