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

    private let repository: any ShowsRepositoryProtocol

    private var loadingShows = false
    private var currentPage = 1
    private var totalShowsLoaded = 0
    private var lastMoviesAdded: [Movie] = []
    private var lastTVShowsAdded: [TVShow] = []
    private var disposeBag = DisposeBag()

    let type: ShowType

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
        // If it is initial load or refresh, remove all shows
        if currentPage == 1 {
            lastMoviesAdded.removeAll()
            lastTVShowsAdded.removeAll()
        }

        loadingShows = true
        switch type {
        case .movie:
            loadMovies()
        case .tv:
            loadTVShows()
        }
    }

    private func loadMovies() {
        guard let genreId = selectedGenre?.id else { return }
        repository.getMovies(page: currentPage, genreId: genreId)
            .observe(on: MainScheduler.instance)
            .subscribe(onSuccess: { [weak self] moviesModel in
                guard let self else { return }

                self.lastMoviesAdded.append(contentsOf: moviesModel.results)
                self.movies.onNext(lastMoviesAdded)
                self.totalShowsLoaded = lastMoviesAdded.count
                self.loadingShows = false
            }).disposed(by: disposeBag)
    }

    private func loadTVShows() {
        guard let genreId = selectedGenre?.id else { return }

        repository.getTVShows(page: currentPage, genreId: genreId)
            .observe(on: MainScheduler.instance)
            .subscribe(onSuccess: { [weak self] showsModel in
                guard let self else { return }

                self.lastTVShowsAdded.append(contentsOf: showsModel.results)
                self.tvShows.onNext(lastTVShowsAdded)
                self.totalShowsLoaded = lastTVShowsAdded.count
                self.loadingShows = false
            }).disposed(by: disposeBag)
    }
}

extension ShowsFeedViewModel {
    func genreSelected(_ genre: Genre) {
        selectedGenre = genre
        currentPage = 1
        loadShows()
    }

    func willDisplayShowAtIndex(index: Int) {
        // Since we get 20 shows per page, if we scroll to the last 10 shows we load another page
        if index > totalShowsLoaded - 10, loadingShows == false {
            currentPage += 1
            loadShows()
        }
    }
}
