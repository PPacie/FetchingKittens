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
    fileprivate struct Constants {
        static let numberOfKittens = 50 // Number of Images to Fetch
        static let sizeOfKittensImages = 600 //Initial size of the images to be fetched. It will increment according to this particular API functionality. Otherwise we will always get the same image.
        static let reuseIdentifier = "Cell"
        static let segueIdentifier = "ShowImage"
    }
    var kittens = Kitten.createArrayOfKittens(numberOfKittens: Constants.numberOfKittens, heightOfImages: Constants.sizeOfKittensImages)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Start activity indicator.
        activityIndicator.color = UIColor.white
        activityIndicator.startAnimating()
        
        collectionView?.reloadData()
        activityIndicator.stopAnimating()
        //Add Pinch Gesture Recognizer.
        collectionView?.addGestureRecognizer(UIPinchGestureRecognizer(target: self, action: (#selector(KittensCollectionViewController.handlePinch(_:)))))
    }

    // MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return kittens.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.reuseIdentifier, for: indexPath) as! KittenImageCell
    
        // Configure the cell
        cell.populateWith(kittens[indexPath.row])
        
        return cell
    }
    
    //MARK: Handle Pinch Gesture Recognizer
    func handlePinch(_ gesture: UIPinchGestureRecognizer) {
        
        let zoomLayout = collectionView?.collectionViewLayout as! ZoomLayout
        
        switch gesture.state {
        case .began:
            let initialPinchPoint = gesture.location(in: collectionView!)
            if let pinchCellPath = self.collectionView?.indexPathForItem(at: initialPinchPoint) {
                zoomLayout.pinchedCellPath = pinchCellPath
            }
        case .changed:
            zoomLayout.pinchedCellScale = gesture.scale
            zoomLayout.pinchedCellCenter = gesture.location(in: collectionView!)
        default:
            collectionView?.performBatchUpdates({ () -> Void in
                zoomLayout.pinchedCellPath = nil;
                zoomLayout.pinchedCellScale = 1.0;
                }, completion: nil)
            break
        }
    }
    
    //MARK: Segue    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.segueIdentifier {
            if let ivc = segue.destination as? ImageViewController {
                if let indexPath = collectionView?.indexPathsForSelectedItems!.first as IndexPath! {
                    if let currentCell = collectionView?.cellForItem(at: indexPath) as? KittenImageCell {
                        ivc.image = currentCell.imageView!.image
                        ivc.title = "Cell: \(indexPath.row)"
                    }
                }
            }
        }
    }
}
