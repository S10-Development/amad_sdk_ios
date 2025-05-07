//
//  SendInformationUseCase.swift
//  amad_sdk_ios
//
//  Created by Pablo Jair Angeles on 04/05/25.
//


import Foundation
import Combine
public class SendInformationUseCase: UseCaseBase<TokenRequestModel, String?> {
    private let repository = ApplicationRepository()

    public override func execute(params request: TokenRequestModel?) -> AnyPublisher<String?, APIError> {
        CacheManager.shared.saveData(Constants.EMPTY_STRING, forKey: CacheManager.shared.APPLICATION_SESION)               

        return repository
            .load(event: request!)
            .tryMap { response in
                // 1) Comprueba el código de estado que consideres éxito
                guard response.status == 200 else {
                    throw APIError.decodingError(
                        NSError(
                            domain: "SendInformationUseCase",
                            code: response.status,
                            userInfo: [NSLocalizedDescriptionKey: "La información no se guardo pero continuaras con el proceso"]
                        )
                    )
                }
                CacheManager.shared.saveData(response.token, forKey: CacheManager.shared.APPLICATION_SESION)                // 2) Devuelve el String? que viene en response.data
                return response.data
            }
            .mapError { error in
                // 3) Mapea cualquier Error a APIError
                if let apiErr = error as? APIError {
                    return apiErr
                } else {
                    return APIError.decodingError(error as NSError)
                }
            }
            .eraseToAnyPublisher()
    }
}
