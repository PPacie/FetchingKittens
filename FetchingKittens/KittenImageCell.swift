//
//  KittenImageCell.swift
//  FetchingKittens
//
//  Created by Pablo Surfate on 9/2/15.
//  Copyright © 2015 Pablo Paciello. All rights reserved.
//

import UIKit

class KittenImageCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    var kitten = Kitten?() {
        didSet {
            updateUI()
         }
    }
    
    private func updateUI() {
        imageView.image = nil
        guard let kittenURL = kitten?.imageURL else { return }
        let request = NSURLRequest(URL: kittenURL)
        //Launch a request to get the NSData and store it into the Kittens Array when succesfull.
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { (data: NSData?, response: NSURLResponse?, error:NSError?) -> Void in
            
            if (error != nil) {
                print("Error: \(error!.localizedDescription)", terminator: "")
            } else {
                //Update the UI
                dispatch_async(dispatch_get_main_queue()) { [weak self] in
                    if let imageData = data where kittenURL == self?.kitten?.imageURL {
                        self?.imageView?.image = UIImage(data: imageData)
                    }
                }
            }
        }
        task.resume()
    
    }






}
