//
//  PhotoInfoViewController.swift
//  Photorama
//
//  Created by ladmin on 7/29/22.
//

import UIKit

class PhotoInfoViewController: UIViewController {
    @IBOutlet var imageView: UIImageView!
    
    var photo: Photo! {
        didSet {
            navigationItem.title = photo.title == "" ? "No Title Provided" : photo.title

        }
    }
    var store:PhotoStore!
    
    override func viewDidLoad() {
        store.fetchImage(for: photo) { result -> Void in
            switch result {
            case let .success(image):
                self.imageView.image = image
            case let .failure(error):
                print("Error fetching image for photo: \(error)")
            }
            
        }
    }
}
