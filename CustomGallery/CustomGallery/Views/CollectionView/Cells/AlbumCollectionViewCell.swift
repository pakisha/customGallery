//
//  AlbumCollectionViewCell.swift
//  CustomGallery
//
//  Created by Pavle Pesic on 7/14/18.
//  Copyright © 2018 Pavle Pesic. All rights reserved.
//

import UIKit
import Photos

class AlbumCollectionViewCell: UICollectionViewCell {

    // MARK: - Outelts
    
    @IBOutlet weak var albumImageView: UIImageView!
    @IBOutlet weak var albumNameLabel: UILabel!
    
    // MARK: - Public methods
    
    func setAlbum(_ album: PHAssetCollection) {
        albumNameLabel.text = album.localizedTitle!
        albumImageView.image = album.getCoverImgWithSize(albumImageView.frame)
    }

}
