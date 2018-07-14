//
//  UIView.swift
//  CustomGallery
//
//  Created by Pavle Pesic on 7/15/18.
//  Copyright © 2018 Pavle Pesic. All rights reserved.
//

import UIKit

extension UIView {
    
    // MARK: - Public methods
    
    func roundedCorners() {
        self.layer.cornerRadius = self.bounds.size.height/2
        self.clipsToBounds = true
    }
    
}
