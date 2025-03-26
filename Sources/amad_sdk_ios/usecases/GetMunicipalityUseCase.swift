//
//  GetApplicationUseCase.swift
//  core
//
//  Created by Pablo Jair Angeles on 08/10/24.
//

import Foundation
import Combine
public class GetMunicipalityUseCase: UseCaseBase<Int,[Municipality]> {
    
    private let repository = SepomexRepository()
    public override func execute(params request: Int?) -> AnyPublisher<[Municipality],APIError> {
        return repository.getMunicipality(id: request! ).eraseToAnyPublisher()
    }
}
