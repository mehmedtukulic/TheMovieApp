//
//  GenreViewCell.swift
//  TheMoviesApp
//
//  Created by Mehmed Tukulic on 15. 8. 2023..
//

import UIKit

final class GenreViewCell: UICollectionViewCell {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var genreNameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setup(genre: Genre, isSelected: Bool) {
        genreNameLabel.text = genre.name
        containerView.layer.cornerRadius = 10
        containerView.backgroundColor = isSelected ? Colors.primaryColor : .gray
    }

}
