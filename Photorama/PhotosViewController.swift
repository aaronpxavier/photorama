//
//  ViewController.swift
//  Photorama
//
//  Created by ladmin on 7/27/22.
//

import UIKit

class PhotosViewController: UIViewController {

    @IBOutlet private var imageView: UIImageView!
    var store: PhotoStore!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        imageView.image = UIImage(named: "PlaceHolderImg")
        store.fetchInterestingPhotos() { result in
            switch result {
            case let .success(photos):
                if let firstPhoto = photos.first {
                    self.updateImageView(for: firstPhoto)
                }
            case let .failure(error):
                print(error)
            }
        }
    }
    
    func updateImageView(for photo: Photo) {
        store.fetchImage(for: photo) { imageResult in
            switch imageResult {
            case let .success(image):
                self.imageView.image = image
            case let .failure(error):
                print("Error downloading image: \(error)")
            }
        }
    }


}

