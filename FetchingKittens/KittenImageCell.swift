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
    
    var imageURL = NSURL?() {
        didSet {
            if imageView!.image == nil {
                updateUI()
            }
        }
    }
    
    private func updateUI() {
        activityIndicator.color = UIColor.whiteColor()
        activityIndicator.startAnimating()
        if let kittenImageURL = imageURL {
            let qos = Int(QOS_CLASS_USER_INITIATED.rawValue)
            dispatch_async(dispatch_get_global_queue(qos , 0)) { () -> Void in
                let imageData = NSData(contentsOfURL: kittenImageURL)
                //blocks main thread!
                dispatch_async(dispatch_get_main_queue()) { () -> Void in
                    if kittenImageURL == self.imageURL {
                        if imageData != nil {
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
