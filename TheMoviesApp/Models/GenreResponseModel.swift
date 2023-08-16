//
//  GenreResponseModel.swift
//  TheMoviesApp
//
//  Created by Mehmed Tukulic on 15. 8. 2023..
//

import Foundation

struct GenreResponseModel: Decodable {
    let genres: [Genre]
}

struct Genre: Decodable {
    let id: Int
    let name: String
}
