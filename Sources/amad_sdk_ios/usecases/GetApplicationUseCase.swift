//
//  GetApplicationUseCase.swift
//  core
//
//  Created by Pablo Jair Angeles on 08/10/24.
//

import Foundation
import Combine
 class GetApplicationUseCase: UseCaseBase<String,AppInformation> {
    
    private let applicationRepository = ApplicationRepository()
    public override func execute(params request: String?) -> AnyPublisher<AppInformation,APIError> {
        applicationRepository.fetchApplications(id: request!).map{
            value in
            return value.data
        }.eraseToAnyPublisher()
    }
}
