//
//  TVShowResponseModel.swift
//  TheMoviesApp
//
//  Created by Mehmed Tukulic on 16. 8. 2023..
//

import Foundation

struct TVShowResponseModel: Decodable {
    let page: Int
    let results: [TVShow]
}

struct TVShow: Decodable {
    let id: Int
    let name: String
    let posterPath: String?
    let voteAverage: Double

    enum CodingKeys: String, CodingKey {
        case id, name
        case posterPath = "poster_path"
        case voteAverage = "vote_average"
    }

    var posterURL: URL? {
        let url = "https://image.tmdb.org/t/p/w500" + (posterPath ?? "/wwemzKWzjKYJFfCeiB57q3r4Bcm.png")
        return URL(string: url)
    }
}
