//
//  GetApplicationUseCase.swift
//  core
//
//  Created by Pablo Jair Angeles on 08/10/24.
//

import Foundation
import Combine
public class GetStatesUseCase: UseCaseBase<Void,[StateResponse]> {
    
    private let repository = SepomexRepository()
    public override func execute(params request: Void?) -> AnyPublisher<[StateResponse],APIError> {
        return repository.getStates().eraseToAnyPublisher()
    }
}
