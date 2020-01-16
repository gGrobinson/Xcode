//
//  pictures.swift
//  George_port2
//
//  Created by George Robinson on 28/03/2019.
//  Copyright © 2019 George Robinson. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class pictures{
    
    var id: String!
    var picture: UIImage?
    var confidence: String!
    var guess: String!
    
    init(id:String, picture:UIImage, confidence: String, guess: String){
        
        self.id = id
        self.picture = picture
        self.confidence = confidence
        self.guess = guess

    }
}
