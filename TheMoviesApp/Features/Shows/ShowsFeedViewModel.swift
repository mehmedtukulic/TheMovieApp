//
//  ShowsFeedViewModel.swift
//  TheMoviesApp
//
//  Created by Mehmed Tukulic on 13. 8. 2023..
//

import Foundation
import RxSwift

enum ShowType {
    case movie
    case tv
}

final class ShowsFeedViewModel {
    private(set) var genres = BehaviorSubject<[Genre]>(value: [])
    private(set) var movies = BehaviorSubject<[Movie]>(value: [])
    private(set) var tvShows = BehaviorSubject<[TVShow]>(value: [])
    private(set) var selectedGenre: Genre?

    let type: ShowType
    private let repository: any ShowsRepositoryProtocol
    private var disposeBag = DisposeBag()

    init(repository: any ShowsRepositoryProtocol,
         type: ShowType) {
        self.repository = repository
        self.type = type
    }

    func viewDidLoad() {
        loadGenres()
    }

    private func loadGenres() {
        repository.getGenres(showType: type)
            .observe(on: MainScheduler.instance)
            .subscribe(onSuccess: { [weak self] genreModel in
                guard let self else { return }
                self.genres.onNext(genreModel.genres)
                self.selectedGenre = genreModel.genres.first
                self.loadShows()
            }).disposed(by: disposeBag)
    }

    private func loadShows() {
        switch type {
        case .movie:
            loadMovies()
        case .tv:
            loadTVShows()
        }
    }

    private func loadMovies() {
        guard let genreId = selectedGenre?.id else { return }

        repository.getMovies(genreId: genreId)
            .observe(on: MainScheduler.instance)
            .subscribe(onSuccess: { [weak self] moviesModel in
                guard let self else { return }
                self.movies.onNext(moviesModel.results)
            }).disposed(by: disposeBag)
    }

    private func loadTVShows() {
        guard let genreId = selectedGenre?.id else { return }

        repository.getTVShows(genreId: genreId)
            .observe(on: MainScheduler.instance)
            .subscribe(onSuccess: { [weak self] showsModel in
                guard let self else { return }
                self.tvShows.onNext(showsModel.results)
            }).disposed(by: disposeBag)
    }
}

extension ShowsFeedViewModel {
    func genreSelected(_ genre: Genre) {
        selectedGenre = genre
        loadShows()
    }
}
