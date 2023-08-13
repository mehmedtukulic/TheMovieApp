//
//  ShowsFeedViewModel.swift
//  TheMoviesApp
//
//  Created by Mehmed Tukulic on 13. 8. 2023..
//

import Foundation

final class ShowsFeedViewModel {
    private let repository: any ShowsRepositoryProtocol

    init(repository: any ShowsRepositoryProtocol) {
        self.repository = repository
    }
}
