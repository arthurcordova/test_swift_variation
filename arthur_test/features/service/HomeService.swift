//
//  HomeService.swift
//  arthur_test
//
//  Created by Arthur Stapassoli on 13/03/23.
//

import Foundation
import Alamofire
import Combine



protocol HomeService {
    
    func getFinancialAsset(parameter : String) -> AnyPublisher<MainResult, AFError>
    
    
}

class HomeServiceImpl: BaseService, HomeService {
    
    func getFinancialAsset(parameter: String) -> AnyPublisher<MainResult, AFError> {
        return AF.request(path(path: parameter),
                          method: .get)
        .validate()
        .publishDecodable(type: MainResult.self)
        .value()
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
    
}
