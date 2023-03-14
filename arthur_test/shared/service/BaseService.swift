//
//  BaseService.swift
//  arthur_test
//
//  Created by Arthur Stapassoli on 13/03/23.
//

import Foundation

class BaseService {
    
    private let baseUrl = "https://query2.finance.yahoo.com";
    private let baseProject = "/v8/finance/chart";

    
    func path(path : String) -> String {
        return "\(baseUrl)/\(baseProject)/\(path)"
    }
}
