//
//  KittenImageCell.swift
//  FetchingKittens
//
//  Created by Pablo Surfate on 9/2/15.
//  Copyright © 2015 Pablo Paciello. All rights reserved.
//

import UIKit

class KittenImageCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView?
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var imageData = NSData() {
        didSet {
            if imageView!.image == nil {
                updateUI()
            }
        }
    }
    
    private func updateUI() {
        activityIndicator.color = UIColor.whiteColor()
        activityIndicator.startAnimating()
        imageView?.image = UIImage(data:imageData)
        activityIndicator.stopAnimating()
    }
        
    

}
