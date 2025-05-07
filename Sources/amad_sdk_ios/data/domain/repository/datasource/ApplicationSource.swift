//
//  ApplicationSource.swift
//  core
//
//  Created by Pablo Jair Angeles on 07/10/24.
//

import Combine


protocol ApplicationDataSource{
    
    func getApplication(id: String) -> AnyPublisher<BaseResponse<AppInformation>, APIError>
    func sendAnalytics(event:EventAnalytics) -> AnyPublisher<BaseResponse<String>, APIError>
    func load(event:TokenRequestModel) -> AnyPublisher<BaseResponse<String?>, APIError>
}
