//
//  ResultHomeStructured.swift
//  arthur_test
//
//  Created by Arthur Stapassoli on 13/03/23.
//

import Foundation
import Alamofire

struct MainResult : Codable&Decodable {
    var chart : Chart?
}

struct Chart : Codable&Decodable {
    var result: [Result]?
}

struct Result : Codable&Decodable {
    var indicators: Indicators?
}

struct Indicators: Codable&Decodable {
    var quote: [Quote]?
}

struct Quote : Codable&Decodable{
    
    var high : [Double?]?
    var low : [Double?]?
    var close : [Double?]?
    var open : [Double?]?
    var volume : [Int?]?
    
}

struct NetworkError: Error {
  let error: AFError?
  let serverError: ServerError?
}

struct ServerError: Codable&Decodable, Error {
    var status: String
    var message: String
}
