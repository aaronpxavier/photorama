//
//  ViewController.swift
//  Photorama
//
//  Created by ladmin on 7/27/22.
//

import UIKit

class PhotosViewController: UIViewController, UICollectionViewDelegate {

    let photoDataSource = PhotoDataSource()
    var store: PhotoStore!
    @IBOutlet var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        initializeCollectionView()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "showPhoto":
            if let selectedIndexPath = collectionView.indexPathsForSelectedItems?.first {
                let photo = photoDataSource.photos[selectedIndexPath.row]
                let destVC = segue.destination as! PhotoInfoViewController
                destVC.photo = photo
                destVC.store = store
            }
        default:
            preconditionFailure("Error fetfching image for photo")
        }
    }
    
    private func initializeCollectionView() {
        collectionView.dataSource = photoDataSource
        collectionView.delegate = self
        self.store.fetchInterestingPhotos() { result in
            switch result {
            case let .success(photos):
                print("\(photos.count) fotos retrieved")
                self.photoDataSource.photos = photos
            case let .failure(error):
                print(error)
                self.photoDataSource.photos.removeAll()
            }
            DispatchQueue.main.async {
                self.collectionView.reloadSections(IndexSet(integer: 0))
            }
        }
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let photo = photoDataSource.photos[indexPath.row]
        guard let photoIndex = self.photoDataSource.photos.firstIndex(of: photo) else {
            return
        }
        
        if let cachedImg = PhotoStore().image(forKey: photo.photoID), let photoCell = cell as? PhotoCollectionViewCell {
            photoCell.update(displaying: cachedImg)
            return
        }
        fetchImage(photo: photo)
    }

    func fetchImage(photo: Photo) {
        store.fetchImage(for: photo) { result -> Void in
            guard let photoIndex = self.photoDataSource.photos.firstIndex(of: photo),
                  case let .success(image) = result else {
                    
                return
            }
            let photoIndexPath = IndexPath(item: photoIndex, section: 0)
            if let cell = self.collectionView.cellForItem(at: photoIndexPath) as? PhotoCollectionViewCell {
                cell.update(displaying: image)
                self.store.setImage(image, forKey: photo.photoID)
            }
        }
    }

    
}

