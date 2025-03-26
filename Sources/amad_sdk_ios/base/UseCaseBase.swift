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

public class UseCaseBase<Input, Output>: UseCaseDefinition {
   
    
    
    public typealias Input = Input
   public typealias Output = Output
    
    
     public init() {}
   
    
     public func execute(params: Input?) -> AnyPublisher<Output, APIError> {
        fatalError("execute() not implemented")
    }
    
}

public protocol UseCaseDefinitionWhitoutParams {
    associatedtype Output
    func execute() -> AnyPublisher<Output, APIError>
}
 class UseCaseBaseWhitoutParams<Output>: UseCaseDefinitionWhitoutParams {
    typealias Output = Output
    public init() {}
    open func execute() -> AnyPublisher<Output, APIError> {
        fatalError("execute() not implemented")
    }
    
}
