//
//  KittenRequest.swift
//  FetchingKittens
//
//  Created by Pablo Surfate on 9/2/15.
//  Copyright © 2015 Pablo Paciello. All rights reserved.
//

import Foundation

public struct Kitten {
    let imageData: NSData
}

class KittenRequest {
    
    let numberOfKittensToFetch: Int
    let sizeOfKittensImages: Int
    
    init(count: Int, imageSize: Int) {
        self.numberOfKittensToFetch = count
        self.sizeOfKittensImages = imageSize
    }
    
   //This fetch request will send the array of Kittens as a callback (only when it gets to the numberOfKittensToFetch).
   func fetchRequest (handler: ([Kitten]) -> Void) {
    
        var newKittens = [Kitten]()
        var fileSize = sizeOfKittensImages
    
        //We loop over the number of Kittens to be fetched + X times, just in case the API fails. We tested it several times and we haven't got any errors so far. But still, just in case.
        for var i = 0; i < numberOfKittensToFetch+10; ++i {
            let kittensURL = NSURL(string:"https://placekitten.com/g/\(fileSize)/\(fileSize)")!
            let request = NSURLRequest(URL: kittensURL)
            //Launch a request to get the NSData and store it into the Kittens Array when succesfull.
            let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { (data: NSData?, response: NSURLResponse?, error:NSError?) -> Void in
                
                if (error != nil) {
                    print("Error: \(error!.localizedDescription)", terminator: "")
                } else {
                    //Add the NSData to the Kittens Array.
                    if (response != nil) {
                        newKittens.append(Kitten(imageData: data!))
                        print("ImageURL: \(kittensURL)", terminator: "")
                    }
                    //We check weather the newKittens Array gets to the requested number of images and send the callback.
                    if newKittens.count == self.numberOfKittensToFetch {
                        handler(newKittens)
                    }
                }
                
                
            }
            task.resume()
            fileSize++
    
        }
    
    
    }
    
}



        

    
