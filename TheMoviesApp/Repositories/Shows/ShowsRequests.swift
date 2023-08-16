//
//  ShowsRequests.swift
//  TheMoviesApp
//
//  Created by Mehmed Tukulic on 15. 8. 2023..
//

import Foundation

enum ShowsRequests: APIRequest {
    case movieGenres
    case movies(page: Int, genreId: Int)
    case tvGenres
    case tvShows(page: Int, genreId: Int)

    var url: String {
        switch self {
        case .movieGenres:
            return "https://api.themoviedb.org/3/genre/movie/list?language=en"
        case .movies(let page, let genreId):
            return "https://api.themoviedb.org/3/discover/movie?include_video=false&language=en-US&page=\(page)&sort_by=popularity.desc&with_genres=\(genreId)"
        case .tvGenres:
            return "https://api.themoviedb.org/3/genre/tv/list?language=en"
        case .tvShows(let page, let genreId):
            return "https://api.themoviedb.org/3/discover/tv?include_null_first_air_dates=false&language=en-US&page=\(page)&sort_by=popularity.descwith_genres=\(genreId)"
        }
    }

    var headers: JSON {
        return [:]
    }

    var params: JSON? {
        return nil
    }

    var method: HTTPMethod {
        .GET
    }

}
