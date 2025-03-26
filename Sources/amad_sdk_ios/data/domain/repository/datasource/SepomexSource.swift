//
//  SepomexSource.swift
//  core
//
//  Created by Pablo Jair Angeles on 17/12/24.
//
import Combine
protocol SepomexSource{
    
    func getStates() -> AnyPublisher<[StateResponse], APIError>
    func getMunicipality(id:Int) -> AnyPublisher<[Municipality], APIError>
    func getNeighborhood(id:Int) -> AnyPublisher<[Neighborhood], APIError>
}
