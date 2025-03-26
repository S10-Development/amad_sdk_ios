//
//  ApplicationRepository.swift
//  core
//
//  Created by Pablo Jair Angeles on 07/10/24.
//

import Combine



struct SepomexRepository {
    private let dataSource: SepomexSource
    
    init() {
        self.dataSource = SepomexSourceImpl()
    }
    func getStates() -> AnyPublisher<[StateResponse], APIError>{
        return dataSource.getStates()
    }
    func getMunicipality(id:Int) -> AnyPublisher<[Municipality], APIError>{
        return dataSource.getMunicipality(id: id)
    }
    func getNeighborhood(id:Int) -> AnyPublisher<[Neighborhood], APIError>{
        return dataSource.getNeighborhood(id: id)
    }
}
