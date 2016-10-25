//
//  ViewController.swift
//  Recipe App
//
//  Created by Kokpheng on 10/18/16.
//  Copyright © 2016 Kokpheng. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating {

    let cellIdentifier = "recipeCell"
    var recipes : [Recipe] = []
    
    var filteredData:[Recipe] = []
    
    var resultSearchController:UISearchController!
    
    
    @IBOutlet var recipeTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.recipeTableView.registerNib(UINib(nibName: "RecipeTableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
        // 1
        resultSearchController = UISearchController(searchResultsController: nil)
        // 2
        resultSearchController.searchResultsUpdater = self
        // 3
        resultSearchController.hidesNavigationBarDuringPresentation = true
        // 4
        resultSearchController.dimsBackgroundDuringPresentation = false
        // 5
        resultSearchController.searchBar.searchBarStyle = UISearchBarStyle.Default
        // 6
        resultSearchController.searchBar.sizeToFit()
        // 7
        recipeTableView.tableHeaderView = resultSearchController.searchBar
        
        self.recipeTableView.setContentOffset(CGPointMake(0, 44), animated: true)
    }
    
    override func viewDidAppear(animated: Bool) {
        recipes = RecipeManager.shareInstance.getRecipes()
        recipeTableView.reloadData()
    }

    // MARK : TableView
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if resultSearchController.active {
            return filteredData.count
        }
        
        return recipes.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = recipeTableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! RecipeTableViewCell
        
        var myRecipe : Recipe
        
        // Configure the cell...
        if resultSearchController.active {
            myRecipe = filteredData[indexPath.row]
        } else {
            myRecipe = recipes[indexPath.row]
        }
        
        cell.nameLabel.text = "\(myRecipe.id) - \(myRecipe.name)"
        cell.thumbnailImageView.image = myRecipe.image
        
        // Create dateFormat object
        let dateFormat = NSDateFormatter()
        dateFormat.dateFormat = "MM dd yyyy"
        cell.dateTimeLabel.text = "Post date: \(dateFormat.stringFromDate(myRecipe.dateTime))"
        return cell
    }
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 200
    }
    
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
         var data : Recipe
        // Configure the cell...
        if resultSearchController.active {
            data = filteredData[indexPath.row]
        } else {
            data = recipes[indexPath.row]        }
        
        self.performSegueWithIdentifier("showDetail", sender: data)
        
    }
    
    // MARK : Search Controller
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        
        if searchController.searchBar.text?.characters.count > 0 {
            // 1
            filteredData.removeAll(keepCapacity: false)
            // 2
            let searchPredicate = NSPredicate(format: "SELF.name CONTAINS[c] %@", searchController.searchBar.text!)
            
            // 3
            let array = (recipes as NSArray).filteredArrayUsingPredicate(searchPredicate)
            // 4
            filteredData = array as! [Recipe]
            // 5
            recipeTableView.reloadData()

        }else{
            // 1
            filteredData.removeAll(keepCapacity: false)
            // 2
            filteredData = recipes
            //3
            recipeTableView.reloadData()
        }
    }
    

    

    // Override to support conditional editing of the table view.
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    
    
    // Override to support editing the table view.
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if editingStyle == .Delete {
            // Delete the row from the data source
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .Normal, title: "Delete") { (action, index) in
            
            // Delete the row from the data source
            self.recipes.removeAtIndex(indexPath.row)
            RecipeManager.shareInstance.deleteRecipe(indexPath.row)
            
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            
        }
        
        let edit = UITableViewRowAction(style: .Default, title: "Edit") { (action, index) in
            self.performSegueWithIdentifier("showEdit", sender: [indexPath.row, self.recipes[indexPath.row]])
        }
        
        edit.backgroundColor = UIColor.brownColor()
        
        return [delete, edit]
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        // Open detail view controller
        if segue.identifier == "showDetail" {
            
            let destView = segue.destinationViewController as! RecipeDetailViewController
            destView.recipe = sender as? Recipe
            resultSearchController.active = false
        }else if segue.identifier == "showEdit" {
            // open add view controller
            let destView = segue.destinationViewController as! AddRecipeViewController
            destView.detailRecipe = sender![1] as? Recipe
            destView.indexNumber = sender![0] as? Int
        }
    }
}
















