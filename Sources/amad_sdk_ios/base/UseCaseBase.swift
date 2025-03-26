//
//  UseCaseBase.swift
//  core
//
//  Created by Pablo Jair Angeles on 08/10/24.
//

import Foundation
import Combine

protocol UseCaseDefinition {
    associatedtype Input
    associatedtype Output
    
    func execute(params: Input?) -> AnyPublisher<Output, APIError>
}

open class UseCaseBase<Input, Output>: UseCaseDefinition {
   
    
    
    typealias Input = Input
    typealias Output = Output
    
    
    public init() {}
   
    
    open func execute(params: Input?) -> AnyPublisher<Output, APIError> {
        fatalError("execute() not implemented")
    }
    
}

protocol UseCaseDefinitionWhitoutParams {
    associatedtype Output
    func execute() -> AnyPublisher<Output, APIError>
}
open class UseCaseBaseWhitoutParams<Output>: UseCaseDefinitionWhitoutParams {
    typealias Output = Output
    public init() {}
    open func execute() -> AnyPublisher<Output, APIError> {
        fatalError("execute() not implemented")
    }
    
}
