//
//  ApiClient.swift
//  PersonalityApp
//
//  Created by Mehmed Tukulic on 9. 5. 2023..
//

import Foundation
import RxSwift

protocol APIProtocol {
    func makeRequest<R:Decodable>(_ session: URLSession, _ request: APIRequest) -> Single<R>
}

class APIClient: APIProtocol {
    func makeRequest<R>(_ session: URLSession, _ request: APIRequest) -> Single<R> where R : Decodable {
        Single.create { [weak self] single in
            guard let self else {
                single(.failure(NetworkingError.selfNotFound))
                return Disposables.create()
            }

            guard let url = URL(string: request.url) else {
                single(.failure(NetworkingError.invalidUrl))
                return Disposables.create()
            }

            var urlRequest = URLRequest(url: url)

            if let parameters = request.params {
                do {
                    urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
                } catch {
                    single(.failure(NetworkingError.failedToEncode(error: error)))
                    return Disposables.create()
                }
            } else {
                urlRequest.httpBody = nil
            }

            urlRequest.httpMethod = request.method.rawValue
            urlRequest.setValue(getAuthorizationHeader(), forHTTPHeaderField: "Authorization")

            let task = session.dataTask(with: urlRequest) { (data, response, error) in
                guard error == nil else {
                    single(.failure(NetworkingError.custom(error: error!)))
                    return
                }

                guard let data = data else {
                    single(.failure(NetworkingError.noDataFound))
                    return
                }

                do {
                    let decoder = JSONDecoder()
                    let result = try decoder.decode(R.self, from: data)
                    single(.success(result))
                } catch {
                    single(.failure(NetworkingError.failedToDecode(error: error)))
                }
            }
            task.resume()

            return Disposables.create {
                task.cancel()
            }
        }
    }
}

extension APIClient {
    private func getAuthorizationHeader() -> String {
        "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJmYjJkYjAzYWE2MTZmOGZkMzBlYzMzZTY5NzI3MDgzNiIsInN1YiI6IjY0ZDk1ZjNkYjc3ZDRiMDBmZmQ2ZGNkYyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.yg1lRuXbXM6-8ilFCNJu9i81cMgR1uLMjEksAdCF4N0"
    }
}

enum NetworkingError: LocalizedError {
    case invalidUrl
    case selfNotFound
    case noDataFound
    case custom(error: Error)
    case invalidStatusCode(statusCode: Int)
    case failedToEncode(error: Error)
    case failedToDecode(error: Error)
}
