//
//  AlbumsViewController.swift
//  CustomGallery
//
//  Created by Pavle Pesic on 7/14/18.
//  Copyright © 2018 Pavle Pesic. All rights reserved.
//

import UIKit
import Photos

class AlbumsViewController: UIViewController {

    // MARK: - Vars & Lets
    
    private var albums: [PHAssetCollection] = []
    private var numbeOfItemsInRow = 3
    
    // MARK: - Outelts
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Controller lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.prepareCollectionView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.checkAutorizationStatus()
    }
    
    // MARK: - Private methods
    
    private func checkAutorizationStatus() {
        PHPhotoLibrary.checkAuthorizationStatus {
            if $0 {
                self.fetchAlbums()
            } else {
                self.showAlertWith(message: AlertMessage(title: "Error", body: "Please authorize gallery access."))
            }
        }
    }
    
    private func fetchAlbums() {
        self.albums.removeAll()
        let result = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .any, options: nil)
        result.enumerateObjects({ (collection, _, _) in
            if (collection.hasAssets()) {
                self.albums.append(collection)
            }
        })
        self.collectionView.reloadData()
    }
    
    private func prepareCollectionView() {
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.register(UINib.init(nibName: "AlbumCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "AlbumCollectionViewCell")
    }
    
}

// MARK: - Exteinsions
// MARK: - UICollectionViewDataSource

extension AlbumsViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return albums.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AlbumCollectionViewCell", for: indexPath) as? AlbumCollectionViewCell
        cell?.setAlbum(albums[indexPath.row])
        
        return cell!
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension AlbumsViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(20, 20, 20, 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (Int(UIScreen.main.bounds.size.width) - (numbeOfItemsInRow - 1) * 10 - 40) / numbeOfItemsInRow
        return CGSize(width: width, height: width + 36)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let photosViewController = UIStoryboard.main.instantiateViewController(withIdentifier: "PhotosViewController") as! PhotosViewController
        let album = albums[indexPath.row]
        photosViewController.title = album.localizedTitle
        photosViewController.selectedCollection = album
        self.navigationController?.pushViewController(photosViewController, animated: true)
    }
}
