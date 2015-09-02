//
//  KittenRequest.swift
//  FetchingKittens
//
//  Created by Pablo Surfate on 9/2/15.
//  Copyright © 2015 Pablo Paciello. All rights reserved.
//

import Foundation

public struct Kitten {
    let imageURL: NSURL
}

class KittenRequest {
    
    let numberOfKittensToFetch: Int
    
    init(count: Int) {
        self.numberOfKittensToFetch = count
    }
    
    func fetchRequest (handler: ([Kitten]) -> Void) {
        
        var newKittens = [Kitten]()
        var sizeFile = 150
        repeat {
            let kittensURL = NSURL(string:"https://placekitten.com/g/\(sizeFile)/\(sizeFile)")!
            let request = NSURLRequest(URL: kittensURL)
            
            let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { (data: NSData?, response: NSURLResponse?, error:NSError?) -> Void in
                
                
                if error != nil {
                    print("Error: \(error!.localizedDescription)")
                } else {
                    print("Response: \(response)")
                    let stringResult = String(data: data!, encoding:
                        NSASCIIStringEncoding)
                    if let pictureURL = NSURL(string: stringResult) {
                        print("New Kitten added: \(pictureURL)")
                        newKittens.append(Kitten(imageURL: pictureURL))
                    }
                    
                }
            
            }
            task.resume()
            sizeFile++
        } while newKittens.count < numberOfKittensToFetch
        
        handler(newKittens)
    
    }
    
    
        
        

    
}