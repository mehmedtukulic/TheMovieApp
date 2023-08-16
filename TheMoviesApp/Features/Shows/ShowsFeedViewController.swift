//
//  ShowsFeedViewController.swift
//  TheMoviesApp
//
//  Created by Mehmed Tukulic on 13. 8. 2023..
//

import UIKit
import RxSwift
import RxCocoa

final class ShowsFeedViewController: UIViewController {
    @IBOutlet private var genresCollectionView: UICollectionView!
    @IBOutlet private var showsCollectionView: UICollectionView!

    private var disposeBag = DisposeBag()
    var viewModel: ShowsFeedViewModel!

    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefresh(_:)),
        for: UIControl.Event.valueChanged)
        refreshControl.tintColor = Colors.primaryColor
        return refreshControl
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        setGenresCollection()
        setShowsCollection()
        bindViewModel()
        viewModel.viewDidLoad()
    }

    private func bindViewModel() {
        // MARK: - Genres
        viewModel.genres.bind(to: genresCollectionView.rx.items) { [weak self] collectionView, row, item in
            let cell = collectionView.dequeueReusableCell(ofType: GenreViewCell.self, indexPath: IndexPath(row: row, section: 0))
            cell.setup(genre: item, isSelected: self?.viewModel.selectedGenre?.id == item.id)
            return cell
        }.disposed(by: disposeBag)

        genresCollectionView.rx.modelSelected(Genre.self).bind { [weak self] in
            self?.viewModel.genreSelected($0)
            self?.genresCollectionView.reloadData()
        }.disposed(by: disposeBag)

        // MARK: - Shows
        if viewModel.type == .movie {
            viewModel.movies.bind(to: showsCollectionView.rx.items) { collectionView, row, item in
                let cell = collectionView.dequeueReusableCell(ofType: ShowViewCell.self, indexPath: IndexPath(row: row, section: 0))
                cell.setup(movie: item)
                return cell
            }.disposed(by: disposeBag)
        } else {
            viewModel.tvShows.bind(to: showsCollectionView.rx.items) { collectionView, row, item in
                let cell = collectionView.dequeueReusableCell(ofType: ShowViewCell.self, indexPath: IndexPath(row: row, section: 0))
                cell.setup(tvShow: item)
                return cell
            }.disposed(by: disposeBag)
        }

        // MARK: - Infinite Scroll
        showsCollectionView.rx.willDisplayCell
                .subscribe(onNext: { [weak self] cell, indexPath in
                    self?.viewModel.willDisplayShowAtIndex(index: indexPath.row)
                }).disposed(by: disposeBag)

        // MARK: - Pull to refresh
        viewModel.refreshingData
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] isRefreshing in
                if !isRefreshing {
                    self?.refreshControl.endRefreshing()
                }
            })
            .disposed(by: disposeBag)
    }

    @objc private func handleRefresh(_ refreshControl: UIRefreshControl) {
        viewModel.refreshData()
    }
}

// MARK: - Collections setup
private extension ShowsFeedViewController {
    func setGenresCollection() {
        genresCollectionView.registerCell(ofType: GenreViewCell.self)

        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize

        genresCollectionView.collectionViewLayout = layout
        genresCollectionView.showsHorizontalScrollIndicator = false
    }

    func setShowsCollection() {
        showsCollectionView.registerCell(ofType: ShowViewCell.self)
        let size = NSCollectionLayoutSize(
            widthDimension: NSCollectionLayoutDimension.fractionalWidth(1),
            heightDimension: NSCollectionLayoutDimension.estimated(300)
        )
        let item = NSCollectionLayoutItem(layoutSize: size)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: size, subitem: item, count: 2)
        let section = NSCollectionLayoutSection(group: group)

        section.interGroupSpacing = 0

        let layout = UICollectionViewCompositionalLayout(section: section)
        layout.configuration.scrollDirection = .vertical
        showsCollectionView.collectionViewLayout = layout
        showsCollectionView.showsVerticalScrollIndicator = false
        showsCollectionView.refreshControl = refreshControl
    }
}
