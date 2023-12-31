//
//  ShowsRepository.swift
//  TheMoviesApp
//
//  Created by Mehmed Tukulic on 14. 8. 2023..
//

import Foundation
import RxSwift

protocol ShowsRepositoryProtocol {
    func getGenres(showType: ShowType) -> Single<GenreResponseModel>
    func getMovies(page: Int, genreId: Int) -> Single<MovieResponseModel>
    func getTVShows(page: Int, genreId: Int) -> Single<TVShowResponseModel>
}

final class ShowsRepository: ShowsRepositoryProtocol {
    let apiClient: any APIProtocol

    init(apiClient: any APIProtocol = APIClient()) {
        self.apiClient = apiClient
    }

    func getGenres(showType: ShowType) -> Single<GenreResponseModel> {
        let request = showType == .movie ? ShowsRequests.movieGenres : ShowsRequests.tvGenres
        return apiClient.makeRequest(URLSession.shared, request)
    }

    func getMovies(page: Int, genreId: Int) -> Single<MovieResponseModel> {
        let request = ShowsRequests.movies(page: page, genreId: genreId)
        return apiClient.makeRequest(URLSession.shared, request)
    }

    func getTVShows(page: Int, genreId: Int) -> Single<TVShowResponseModel> {
        let request = ShowsRequests.tvShows(page: page, genreId: genreId)
        return apiClient.makeRequest(URLSession.shared, request)
    }

}
