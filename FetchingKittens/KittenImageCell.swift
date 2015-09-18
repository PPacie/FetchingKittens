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
            updateUI()
         }
    }
    
    private func updateUI() {
        activityIndicator.color = UIColor.whiteColor()
        activityIndicator.startAnimating()
        if let kittenURL = kitten?.imageURL {
            let request = NSURLRequest(URL: kittenURL)
            //Launch a request to get the NSData and store it into the Kittens Array when succesfull.
            let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { (data: NSData?, response: NSURLResponse?, error:NSError?) -> Void in
        
                if (error != nil) {
                    print("Error: \(error!.localizedDescription)", terminator: "")
                } else {
                    //Update the UI
                    dispatch_async(dispatch_get_main_queue()) { () -> Void in
                        if kittenURL == self.kitten?.imageURL {
                            if let imageData = data {
                                self.imageView?.image = UIImage(data: imageData)
                                self.activityIndicator.stopAnimating()
                            }
                        }
                    }
                }
            }            
            task.resume()
        }
        
    }
        
        
    
        
    

}
