//
//  ShowsRepository.swift
//  TheMoviesApp
//
//  Created by Mehmed Tukulic on 14. 8. 2023..
//

import Foundation

protocol ShowsRepositoryProtocol {
    func getShows() async throws -> [String]
}

class ShowsRepository: ShowsRepositoryProtocol {
    enum RepositoryType {
        case movie
        case tv
    }

    let type: RepositoryType

    init(type: RepositoryType) {
        self.type = type
    }

    func getShows() async throws -> [String] {
        return []
    }


}
