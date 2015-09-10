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
    
    var kitten = Kitten?() {
        didSet {
            //We will update the image (ramdonly) if the kitten's API fails. So we will always get all the Cells of the CollectionView filled with some image.
            if imageView!.image == nil {
                print("ImageView is NIL - updateUI")
                updateUI()
            }
        }
    }
    
    private func updateUI() {
        activityIndicator.color = UIColor.whiteColor()
        activityIndicator.startAnimating()
        if let kittenImageURL = kitten?.imageURL {
            let qos = Int(QOS_CLASS_USER_INITIATED.rawValue)
            dispatch_async(dispatch_get_global_queue(qos , 0)) { () -> Void in
                let imageData = NSData(contentsOfURL: kittenImageURL)
                //blocks main thread!
                dispatch_async(dispatch_get_main_queue()) { () -> Void in
                    if kittenImageURL == self.kitten?.imageURL {
                        if imageData != nil {
                            print("Update ImageView with URL: \(kittenImageURL)")
                            self.imageView?.image = UIImage(data: imageData!)
                        } else {
                            self.imageView?.image = nil
                        }
                        self.activityIndicator.stopAnimating()
                    }
                    
                }
            }

        }        
        
    }
        
        
    
        
    

}
