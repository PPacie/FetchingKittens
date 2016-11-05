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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
    
    func populateWith (_ kitten: Kitten) {
        
        let request = URLRequest(url: kitten.imageURL)
        //Launch a request to get the NSData and store it into the Kittens Array when succesfull.

        let task = URLSession.shared.dataTask(with: request) { (data, _, error) in
            if (error != nil) {
                print("Error: \(error!.localizedDescription)", terminator: "")
            } else {
                //Update the UI
                DispatchQueue.main.async { [weak self] in
                    if let imageData = data {
                        self?.imageView?.image = UIImage(data: imageData)
                    }
                }
            }
        }
        task.resume()
    }
}
