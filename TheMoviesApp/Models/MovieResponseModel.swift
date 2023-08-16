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
    let poster_path: String
    let vote_average: Double

    var posterURL: URL? {
        let url = "https://image.tmdb.org/t/p/w500" + poster_path
        return URL(string: url)
    }
}
