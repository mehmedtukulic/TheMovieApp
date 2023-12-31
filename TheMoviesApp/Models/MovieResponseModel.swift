//
//  MovieResponseModel.swift
//  TheMoviesApp
//
//  Created by Mehmed Tukulic on 16. 8. 2023..
//

import Foundation

struct MovieResponseModel: Decodable {
    let page: Int
    let results: [Movie]
}

struct Movie: Decodable {
    let id: Int
    let title: String
    let posterPath: String
    let voteAverage: Double

    enum CodingKeys: String, CodingKey {
        case id, title
        case posterPath = "poster_path"
        case voteAverage = "vote_average"
    }

    var posterURL: URL? {
        let url = "https://image.tmdb.org/t/p/w500" + posterPath
        return URL(string: url)
    }
}
