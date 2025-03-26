//
//  SepomexSourceImpl.swift
//  core
//
//  Created by Pablo Jair Angeles on 17/12/24.
//


import Combine
struct SepomexSourceImpl:SepomexSource{
    let apiClient = APIClient(baseURL: "https://api.s10plus.com/s10-sepomex.php/")

    func getStates() -> AnyPublisher<[StateResponse], APIError> {
        return apiClient.fetchData(from: SepomexEndPoints.GET_STATES.value,headers: ["api-key":"da92864fb79a129cd7a4ea6d1af259375fe6c9854d9cd83e9c9c8933e6bd21ba"])
    }
    
    func getMunicipality(id: Int) -> AnyPublisher<[Municipality], APIError> {
        return apiClient.fetchData(from: SepomexEndPoints.GET_MUNICIPALITIES(id: id).value,headers: ["api-key":"da92864fb79a129cd7a4ea6d1af259375fe6c9854d9cd83e9c9c8933e6bd21ba"])
    }
    
    func getNeighborhood(id: Int) -> AnyPublisher<[Neighborhood], APIError> {
        return apiClient.fetchData(from: SepomexEndPoints.GET_NEIGHBOODS(id: id).value,headers: ["api-key":"da92864fb79a129cd7a4ea6d1af259375fe6c9854d9cd83e9c9c8933e6bd21ba"])
    }
}
