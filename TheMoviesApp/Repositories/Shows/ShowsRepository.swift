//
//  ShowsRepository.swift
//  TheMoviesApp
//
//  Created by Mehmed Tukulic on 14. 8. 2023..
//

import Foundation
import RxSwift

protocol ShowsRepositoryProtocol {
    func getGenres() -> Single<GenreResponseModel>
    func getMovies(genreId: Int) -> Single<MovieResponseModel>
    func getTVShows(genreId: Int) -> Single<[String]>
}

final class ShowsRepository: ShowsRepositoryProtocol {
    let apiClient: any APIProtocol

    init(apiClient: any APIProtocol = APIClient()) {
        self.apiClient = apiClient
    }

    func getGenres() -> Single<GenreResponseModel> {
        let request = ShowsRequests.movieGenres
        return apiClient.makeRequest(URLSession.shared, request)
    }

    func getMovies(genreId: Int) -> Single<MovieResponseModel> {
        let request = ShowsRequests.movies(page: 1, genreId: genreId)
        return apiClient.makeRequest(URLSession.shared, request)
    }

    func getTVShows(genreId: Int) -> Single<[String]> {
        let request = ShowsRequests.movies(page: 1, genreId: genreId)
        return apiClient.makeRequest(URLSession.shared, request)
    }

}
