//
//  RecipeDetailViewController.swift
//  Recipe App
//
//  Created by Kokpheng on 10/18/16.
//  Copyright © 2016 Kokpheng. All rights reserved.
//

import UIKit

class RecipeDetailViewController: UIViewController {
    
    @IBOutlet var titleNavigationItem: UINavigationItem!
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var dateTimeLabel: UILabel!
    @IBOutlet var detailTextView: UITextView!
    
    @IBOutlet var imageView: UIImageView!
    var recipe : Recipe?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = recipe?.name
        detailTextView.text = recipe?.recipeDescription
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MM dd yyyy"
        dateTimeLabel.text = "Post date: \(dateFormatter.stringFromDate(recipe!.dateTime!))"
        
        imageView.image = recipe?.image
        
    }
    
    @IBAction func backAction(sender: AnyObject) {
        
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
}
