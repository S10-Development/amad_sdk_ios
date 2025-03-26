//
//  SendAnalyticsUseCase.swift
//  core
//
//  Created by Pablo Jair Angeles on 09/12/24.
//

import Foundation
import Combine
 class SendAnalyticsUseCase: UseCaseBase<EventAnalytics,String> {
    
    private let applicationRepository = ApplicationRepository()
    
    public override func execute(params request: EventAnalytics?) -> AnyPublisher<String,APIError> {
        applicationRepository.sendAnalytics(event: request!).map{
            value in
            return value.data
        }.eraseToAnyPublisher()
    }
}
