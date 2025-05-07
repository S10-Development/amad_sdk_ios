//
//  ApplicationRepository.swift
//  core
//
//  Created by Pablo Jair Angeles on 07/10/24.
//

import Combine



struct ApplicationRepository {
    private let applicationDataSource: ApplicationDataSource
    
    init() {
        self.applicationDataSource = ApplicationDataSourceImpl()
    }
    
    public func fetchApplications(id: String) -> AnyPublisher<BaseResponse<AppInformation>, APIError> {
        return applicationDataSource.getApplication(id: id)
    }
    
    public func sendAnalytics(event: EventAnalytics) -> AnyPublisher<BaseResponse<String>, APIError> {
        return applicationDataSource.sendAnalytics(event: event)
    }
    
    func load(event:TokenRequestModel) -> AnyPublisher<BaseResponse<String?>, APIError> {
        return applicationDataSource.load(event: event)
    }
}
