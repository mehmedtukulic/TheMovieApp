//
//  ShowViewCell.swift
//  TheMoviesApp
//
//  Created by Mehmed Tukulic on 16. 8. 2023..
//

import UIKit
import Kingfisher

final class ShowViewCell: UICollectionViewCell {

    @IBOutlet private var containerView: UIView!
    @IBOutlet private var posterImageView: UIImageView!
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var subtitleLabel: UILabel!
    @IBOutlet private var info1Label: UILabel!
    @IBOutlet private var info2Label: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        posterImageView.kf.cancelDownloadTask()
        posterImageView.image = nil
        titleLabel.text = String()
        subtitleLabel.text = String()
        info1Label.text = String()
        info2Label.text = String()
    }

    func setup(movie: Movie) {
        posterImageView.kf.setImage(with: movie.posterURL)
        containerView.backgroundColor = Colors.primaryColor
        titleLabel.text = "Title: \(movie.title)"
        subtitleLabel.text = "Rating: \(movie.vote_average)"
        info1Label.text = "Budget"
        info2Label.text = "Revenue"
    }

}
