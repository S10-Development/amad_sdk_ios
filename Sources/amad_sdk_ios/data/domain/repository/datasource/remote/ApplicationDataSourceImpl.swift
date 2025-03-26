//
//  ApplicationDataSourceImpl.swift
//  core
//
//  Created by Pablo Jair Angeles on 07/10/24.
//

import Combine

struct ApplicationDataSourceImpl: ApplicationDataSource {
    let apiClient = APIClient()

    func getApplication(id: String) -> AnyPublisher<BaseResponse<AppInformation>, APIError> {
        let isDemo = SessionManager.shared.getDemo()
        return if isDemo {
            apiClient.fetchData(from: EndPoints.APPLICATION_SERVICES(id: id).value)
        }else{
            apiClient.fetchData(baseUrlParams: "https://s10plus.com:8443/wsqa/", from: EndPoints.APPLICATION_SERVICES(id: id).value)
        }
    }
    
    func sendAnalytics(event:EventAnalytics) -> AnyPublisher<BaseResponse<String>, APIError> {
        return apiClient.fetchData(from: EndPoints.SEND_CLICK.value, method: .post, body: event)
    }
    
    
}
