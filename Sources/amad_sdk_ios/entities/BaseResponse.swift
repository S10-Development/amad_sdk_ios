//
//  BaseResponse.swift
//  core
//
//  Created by Pablo Jair Angeles on 08/10/24.
//

 struct BaseResponse<T:Codable>: Codable {
    public let data: T
    public let status: Int
    public let message: String
    public let errorDetails: String?
    public let token: String?
    public let errorCode: String?
    
}
