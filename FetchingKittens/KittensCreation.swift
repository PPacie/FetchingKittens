//
//  KittenRequest.swift
//  FetchingKittens
//
//  Created by Pablo Surfate on 9/2/15.
//  Copyright © 2015 Pablo Paciello. All rights reserved.
//

import Foundation

struct Kitten {
    let imageURL: NSURL
}

class KittensCreation {
    
    let numberOfKittensToFetch: Int
    let sizeOfKittensImages: Int
    
    init(count: Int, imageSize: Int) {
        self.numberOfKittensToFetch = count
        self.sizeOfKittensImages = imageSize
    }
    
    //Create an Array of Kitten struct. Lenght of the array will be the "numberOfKittensToFetch" and image sizes will start with the "sizeOfKittensImages" which will increment to avoid having the same "n" images.
    func createArrayOfKittens() -> [Kitten] {
        var fileSize = sizeOfKittensImages
        var kittens = [Kitten]()
        for _ in 0..<numberOfKittensToFetch {
            guard let kittenURL = NSURL(string:"https://placekitten.com/g/\(fileSize)/\(fileSize)") else { break }
            print("Kitten URL Added: \(kittenURL)")
            kittens.append(Kitten(imageURL: kittenURL))
            fileSize++
        }
        return kittens
    }
}




        

    
