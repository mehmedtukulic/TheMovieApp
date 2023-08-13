//
//  MainTabController.swift
//  TheMoviesApp
//
//  Created by Mehmed Tukulic on 13. 8. 2023..
//

import Foundation
import UIKit

final class MainTabController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        setupTabBar()
        loadTabViewControllers()
    }

    private func setupTabBar(){
        tabBar.backgroundColor = .white.withAlphaComponent(0.3)
        tabBar.unselectedItemTintColor = Colors.primaryColor
        tabBar.tintColor = Colors.tabItemsColor
    }

    private func loadTabViewControllers() {
        var tabViewControllers: [UINavigationController] = []
        tabViewControllers.append(UINavigationController(rootViewController: composeMoviesViewController()))
        tabViewControllers.append(UINavigationController(rootViewController: composeTvShowsViewController()))

        viewControllers = tabViewControllers
    }

    private func composeMoviesViewController() -> ShowsFeedViewController {
        let vc = ShowsFeedViewController()
        vc.viewModel = ShowsFeedViewModel(repository: ShowsRepository(type: .movie))
        vc.title = "Movie"
        vc.tabBarItem.image = UIImage(systemName: "stopwatch")
        return vc
    }

    private func composeTvShowsViewController() -> ShowsFeedViewController {
        let vc = ShowsFeedViewController()
        vc.viewModel = ShowsFeedViewModel(repository: ShowsRepository(type: .tv))
        vc.title = "TV"
        vc.tabBarItem.image = UIImage(systemName: "stopwatch")
        return vc
    }
}
