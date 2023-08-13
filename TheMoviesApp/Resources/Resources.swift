//
//  Resources.swift
//  TheMoviesApp
//
//  Created by Mehmed Tukulic on 13. 8. 2023..
//

import Foundation
import UIKit

private let darkMode = UITraitCollection.current.userInterfaceStyle == .dark

struct Colors {
    static let primaryColor = darkMode ? #colorLiteral(red: 0.09019608051, green: 0, blue: 0.3019607961, alpha: 1) : #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1)
    static let tabItemsColor = darkMode ? #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1) : #colorLiteral(red: 0.09019608051, green: 0, blue: 0.3019607961, alpha: 1)
}
