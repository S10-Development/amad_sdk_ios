//
//  GetApplicationUseCase.swift
//  core
//
//  Created by Pablo Jair Angeles on 08/10/24.
//

import Foundation
import Combine
public class GetNeighborhoodUseCase: UseCaseBase<Int,[Neighborhood]> {
    private let repository = SepomexRepository()
    public override func execute(params request: Int?) -> AnyPublisher<[Neighborhood],APIError> {
        return repository.getNeighborhood(id: request! ).eraseToAnyPublisher()
    }
}
