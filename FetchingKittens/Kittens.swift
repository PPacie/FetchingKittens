//
//  Kitten.swift
//  FetchingKittens
//
//  Created by Pablo Surfate on 9/2/15.
//  Copyright © 2015 Pablo Paciello. All rights reserved.
//

import Foundation

struct Kitten {
    let imageURL: URL
}

extension Kitten {
    
    // Create an Array of Kitten. Lenght of the array will be the "numberOfKittens" and image sizes will start with the
    // "heightOfImages" which will increment to avoid having the same images.
    static func createArrayOfKittens(numberOfKittens: Int, heightOfImages: Int) -> [Kitten] {
        
        var fileSize = heightOfImages
        var kittens = [Kitten]()
        for _ in 0..<numberOfKittens {
            guard let kittenURL = URL(string:"https://placekitten.com/g/\(fileSize)/\(fileSize)") else { break }
            print("Kitten URL Added: \(kittenURL)")
            kittens.append(Kitten(imageURL: kittenURL))
            fileSize += 1
        }
        return kittens
    }
}
