//
//  KittensCollectionViewController.swift
//  FetchingKittens
//
//  Created by Pablo Surfate on 9/2/15.
//  Copyright © 2015 Pablo Paciello. All rights reserved.
//

import UIKit

class KittensCollectionViewController: UICollectionViewController {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    //MARK: Model
    private struct Constants {
        static let numberOfKittens = 50 // Number of Images to Fetch
        static let sizeOfKittensImages = 100 //Initial size of the images to be fetched. It will increment according to this particular API functionality. Otherwise we will always get the same image.
        static let reuseIdentifier = "Cell"
    }
    
    var kittens = [Kitten]()
    var kittenRequest = KittenRequest(count: Constants.numberOfKittens, imageSize: Constants.sizeOfKittensImages)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.color = UIColor.whiteColor()
        activityIndicator.startAnimating()
        //Fetch the Kittens and add them to the array.
        kittenRequest.fetchRequest { (newKittens) -> Void in
            dispatch_async(dispatch_get_main_queue()) { () -> Void in
                if newKittens.count > 0 {
                    self.kittens = newKittens
                    print("CollectinViewKittens: \(self.kittens.count)")
                    self.collectionView?.reloadData()
                    self.activityIndicator.stopAnimating()
                }
            }
        }
    }

    // MARK: UICollectionViewDataSource

    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return kittens.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(Constants.reuseIdentifier, forIndexPath: indexPath) as! KittenImageCell
    
        // Configure the cell
        cell.imageData = kittens[indexPath.row].imageData
        
        return cell
    }


}
