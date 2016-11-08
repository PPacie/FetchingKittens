//
//  ImageViewController.swift
//  FetchingKittens
//
//  Created by Pablo Surfate on 9/3/15.
//  Copyright © 2015 Pablo Paciello. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {
    
    //MARK: Variables
    var imageView = UIImageView()
    fileprivate var scrollViewDidScrollOrZoom = false
    
    //MARK: ScrollView
    @IBOutlet weak var scrollView: UIScrollView! {
        didSet {
            scrollView.delegate = self
            scrollView.minimumZoomScale = 0.03
            scrollView.maximumZoomScale = 5.0
            scrollView.addSubview(imageView)
        }
    }

    //MARK: View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.sizeToFit()
        scrollViewDidScrollOrZoom = false
        autoScale()
    }
}

    //MARK: ScrollView Delegate
extension ImageViewController: UIScrollViewDelegate {
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollViewDidScrollOrZoom = true
        centerScrollViewContents()
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        scrollViewDidScrollOrZoom = true
        centerScrollViewContents()
    }
    
    func autoScale() {
        if scrollViewDidScrollOrZoom {
            return
        }
        if let sv = scrollView {
            guard let image = imageView.image else { return }
            let zoomScale = min(sv.bounds.size.height / image.size.height,
                                sv.bounds.size.width / image.size.width)
            
            if zoomScale > sv.maximumZoomScale {
                sv.maximumZoomScale = zoomScale
            }
            sv.zoomScale = zoomScale

            scrollViewDidScrollOrZoom = false
        }
    }
    
    func centerScrollViewContents() {
        
        let boundsSize = scrollView.bounds.size
        var contentsFrame = imageView.frame
        
        if contentsFrame.size.width < boundsSize.width {
            contentsFrame.origin.x = (boundsSize.width - contentsFrame.size.width) / 2.0
        } else {
            contentsFrame.origin.x = 0.0
        }
        
        if contentsFrame.size.height < boundsSize.height {
            contentsFrame.origin.y = (boundsSize.height - contentsFrame.size.height) / 2.0
        } else {
            contentsFrame.origin.y = 0.0
        }
        
        imageView.frame = contentsFrame
    }
}
