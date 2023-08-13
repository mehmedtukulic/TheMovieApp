//
//  ShowsFeedViewController.swift
//  TheMoviesApp
//
//  Created by Mehmed Tukulic on 13. 8. 2023..
//

import UIKit

final class ShowsFeedViewController: UIViewController {
    var viewModel: ShowsFeedViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

}
