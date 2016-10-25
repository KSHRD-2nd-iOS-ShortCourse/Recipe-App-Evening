//
//  Recipe.swift
//  Recipe App
//
//  Created by Kokpheng on 10/21/16.
//  Copyright © 2016 Kokpheng. All rights reserved.
//

import UIKit

class Recipe : NSObject {
    var id : Int!
    var name : String!
    var recipeDescription : String!
    var dateTime : NSDate!
    var image : UIImage!
    
    init(id: Int, name: String, recipeDescription: String, dateTime: NSDate, image: UIImage) {
        super.init()
        self.id = id
        self.name = name
        self.recipeDescription = recipeDescription
        self.dateTime = dateTime
        self.image = image
    }
    
    private override init() {    }
    
    
    override var description: String{
        return "Recipe Class"
    }
}





