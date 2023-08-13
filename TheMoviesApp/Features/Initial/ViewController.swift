//
//  ViewController.swift
//  TheMoviesApp
//
//  Created by Mehmed Tukulic on 13. 8. 2023..
//

import UIKit

final class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        loadMainTab()
    }

    private func loadMainTab() {
        let mainTabVC = MainTabController()
        navigationController?.setViewControllers([mainTabVC], animated: true)
    }
}

