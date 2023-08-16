//
//  ApiRequest.swift
//  PersonalityApp
//
//  Created by Mehmed Tukulic on 9. 5. 2023..
//

import Foundation

protocol APIRequest {
    var url: String { get }
    var headers: JSON { get }
    var params: JSON? { get }
    var method: HTTPMethod { get }
}

public typealias JSON = [String: Any]

enum HTTPMethod: String {
    case GET
    case POST
    case PUT
    case DELETE
}
