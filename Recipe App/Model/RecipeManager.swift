//
//  RecipeManager.swift
//  Recipe App
//
//  Created by Kokpheng on 10/21/16.
//  Copyright © 2016 Kokpheng. All rights reserved.
//

import UIKit

class RecipeManager: NSObject {
    private var recipes = [Recipe]()
    
    static let shareInstance = RecipeManager()
    
    private override init() {
        let images = ["egg_benedict.jpg",
                      "mushroom_risotto.jpg",
                      "full_breakfast.jpg",
                      "hamburger.jpg",
                      "ham_and_egg_sandwich.jpg",
                      "creme_brelee.jpg",
                      "white_chocolate_donut.jpg",
                      "starbucks_coffee.jpg",
                      "vegetable_curry.jpg",
                      "instant_noodle_with_egg.jpg",
                      "noodle_with_bbq_pork.jpg",
                      "japanese_noodle_with_pork.jpg",
                      "green_tea.jpg",
                      "thai_shrimp_cake.jpg",
                      "angry_birds_cake.jpg",
                      "ham_and_cheese_panini.jpg"]
        
        let names = ["Egg Benedict",
                     "Mushroom Risotto",
                     "Full Breakfast",
                     "Hamburger",
                     "Ham and Egg Sandwich",
                     "Creme Brelee",
                     "White Chocolate Donut",
                     "Starbucks Coffee",
                     "Vegetable Curry",
                     "Instant Noodle with Egg",
                     "Noodle with BBQ Pork",
                     "Japanese Noodle with Pork",
                     "Green Tea",
                     "Thai Shrimp Cake",
                     "Angry Birds Cake",
                     "Ham and Cheese Panini"]
        
        //Dummy list of recipes
        for i in 0.stride(to: names.count, by: 1) {
            
            recipes.append(Recipe(id: i + 1, name: names[i], recipeDescription: "Description -> \(names[i])", dateTime: NSDate(), image: UIImage(named: "\(images[i])")!))
        }
    }
    
    func getRecipes() -> [Recipe] {
        return recipes
    }
    
    func addRecipe(recipe: Recipe, index: Int) {
        
        // index = 5
        // count = 10 
        // add new element to index 5
        if (recipes.count >= index) {
            recipes.insert(recipe, atIndex: index)
        } else {
            recipes.append(recipe)
        }
    }
    
    func addRecipe(recipe : Recipe) {
         recipes.append(recipe)
    }
    
    func deleteRecipe(index: Int) {
        recipes.removeAtIndex(index)
    }
    
    
    func updateRecipe(recipe: Recipe, index: Int) {
        recipes[index] = recipe
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}