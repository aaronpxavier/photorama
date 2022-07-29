//
//  PhotoCollectionViewCell.swift
//  Photorama
//
//  Created by ladmin on 7/29/22.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var spinner: UIActivityIndicatorView!
    
    func update(displaying image: UIImage?) {
        if let imageToDisplay = image {
            spinner.stopAnimating()
            spinner.isHidden = true
            imageView.image = imageToDisplay
        } else {
            spinner.isHidden = false
            spinner.startAnimating()
            imageView.image = nil
        }
    }
}

