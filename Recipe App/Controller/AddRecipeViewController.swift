//
//  AddRecipeViewController.swift
//  Recipe App
//
//  Created by Kokpheng on 10/Users/kokpheng/Desktop/Recipe App/Recipe App/20/16.
//  Copyright © 2016 Kokpheng. All rights reserved.
//

import UIKit
import MaterialControls

class AddRecipeViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var detailRecipe : Recipe?
    var indexNumber : Int?
    
    @IBOutlet var nameLabel: MDTextField!
    
    @IBOutlet var descriptionLabel: MDTextField!
    
    @IBOutlet var recipeImageView: UIImageView!
    
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // send from edit button
        if detailRecipe != nil {
            nameLabel.text = detailRecipe?.name
            descriptionLabel.text = detailRecipe?.recipeDescription
            recipeImageView.image = detailRecipe?.image
        }
        
        
        // set delegate for imagePicker
        imagePicker.delegate = self
        
    }
    
    @IBAction func browseImage(sender: AnyObject) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .PhotoLibrary
        
        // show image picker
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    // MARK: - UIImagePickerControllerDelegate Methods
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage{
            recipeImageView.contentMode = .ScaleAspectFit
            recipeImageView.image = pickedImage
        }
        
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    // MARK: - Take Photo
    @IBAction func openCameraButton(sender: AnyObject) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) {
            imagePicker.sourceType = UIImagePickerControllerSourceType.Camera;
            imagePicker.allowsEditing = false
            self.presentViewController(imagePicker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        recipeImageView.image = image
        self.dismissViewControllerAnimated(true, completion: nil);
    }
    
    @IBAction func save(sender: AnyObject) {
        
        if nameLabel.text != "" && descriptionLabel.text != "" {
            // generate id
            let lastId = (RecipeManager.shareInstance.getRecipes().last?.id)! + 1
            
            // create recipe object
            let recipe = Recipe(id: lastId, name: nameLabel.text, recipeDescription: descriptionLabel.text, dateTime: NSDate(), image: recipeImageView.image!)
            
            // send from edit button
            if detailRecipe != nil {
                RecipeManager.shareInstance.updateRecipe(recipe, index: indexNumber!)
            }else{
                // add recipe object to array
                RecipeManager.shareInstance.addRecipe(recipe)
            }
            
            // Go back
            navigationController?.popViewControllerAnimated(true)
            
        }
    }
    
}













