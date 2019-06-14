//
//  RecipeCollectionViewController.swift
//  Final
//
//  Created by 고상원 on 2019-06-13.
//  Copyright © 2019 고상원. All rights reserved.
//

import UIKit
import CoreData



class RecipeCollectionViewController: BaseCollectionViewController, UICollectionViewDelegateFlowLayout, AddRecipeControllerDelegate, RecipeCellDelegate {
   
    

    
    private let reuseIdentifier = "reipeCell"
    
    private var recipes = [Recipe]()
    
    var startFrame: CGRect?
    private var fullScreenController: FullRecipeViewController!
    
    // blur background visual effect
    //private let blurVisualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .regular))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        view.addSubview(blurVisualEffectView)
        //        blurVisualEffectView.matchParent()
        //        blurVisualEffectView.alpha = 0
        collectionView.backgroundColor = .white
        collectionView.register(RecipeCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addRecipe))
        navigationItem.leftBarButtonItem = editButtonItem
        
        fetchRecipes()
        
        
    }
    
    @objc func addRecipe() {
        let addRecipeVC = AddRecipeViewController()
        addRecipeVC.delegate = self
        navigationController?.pushViewController(addRecipeVC, animated: true)
    }
    
    private func fetchRecipes() {
        // NSManagedObjectContext: scratch pad
        // - viewContext: ManagedObjectContext (main thread)
        let managedContext = CoreDataManager.shared.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<Recipe>(entityName: "Recipe")
        do {
            let recipes =  try managedContext.fetch(fetchRequest)
            self.recipes = recipes
            collectionView.reloadData()
        } catch let err {
            print("Failed to fetch recipes: \(err)")
        }
    }
    
    func addRecipeDidFinish(recipe: Recipe) {
        recipes.append(recipe)
        collectionView.reloadData()
        //        let insertPath = IndexPath(item: recipes.count - 1, section: 0)
        //        collectionView.insertItems(at: [insertPath])
    }
    
    func editRecipeDidFinish(recipe: Recipe) {
        let item = recipes.firstIndex(of: recipe)!
        collectionView.reloadItems(at: [IndexPath(item: item, section: 0)])
    }
    
    
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return recipes.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! RecipeCollectionViewCell
        cell.recipe = recipes[indexPath.item]
        
        cell.delegate = self
        return cell
    }
    

    
    func delete(cell: RecipeCollectionViewCell) {
        if let indexPath = collectionView?.indexPath(for: cell) {
            recipes.remove(at: indexPath.item)
            collectionView?.deleteItems(at: [indexPath])
            
            CoreDataManager.shared.persistentContainer.viewContext.delete(recipes[indexPath.item])
            CoreDataManager.shared.saveContext()
        }
    }
    
    
    
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //        let addRecipeVC = FullRecipeViewController()
        //        navigationController?.pushViewController(addRecipeVC, animated: true)
        //        fullScreenController = FullRecipeViewController()
        //
        //        fullScreenController.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(removeTestView)))
        //        view.addSubview(fullScreenController.view)
        //        addChild(fullScreenController)
        //
        //        //selected cell
        //        guard let cell = collectionView.cellForItem(at: indexPath) else { return }
        //
        //        //frame for animation -> absloute coordinate of cell
        //        guard let startFrame = cell.superview?.convert(cell.frame, to: nil) else { return }
        //        self.startFrame = startFrame
        //        fullScreenController.view.frame = startFrame
        //        fullScreenController.view.layer.cornerRadius = 16
        //
        //        // animation
        //        UIView.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut,
        //                       animations: {
        //                        //what to animate
        //                        self.fullScreenController.view.frame = self.view.frame
        //                        self.tabBarController?.tabBar.transform = CGAffineTransform(translationX: 0, y: 100)
        //                        self.navigationController?.setNavigationBarHidden(true, animated: true)
        //
        //        }) { (_) in
        //            // what to do right after animation
        //        }
        
        
        let editVC = AddRecipeViewController()
        editVC.delegate = self
        editVC.recipe = self.recipes[indexPath.item]
        
        // modal transition
        //        self.present(editVC, animated: true, completion: nil)
        navigationController?.pushViewController(editVC, animated: true)
    }
    
    @objc func removeTestView(gesture: UITapGestureRecognizer) {
        //i want to go back
        UIView.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut,
                       animations: {
                        // how to access my testview
                        gesture.view?.frame = self.startFrame ?? .zero
                        self.tabBarController?.tabBar.transform = .identity
                        self.navigationController?.setNavigationBarHidden(false, animated: true)
                        
        }) { (_) in
            gesture.view?.removeFromSuperview()
            self.fullScreenController.removeFromParent()
        }
    }
    
        override func setEditing(_ editing: Bool, animated: Bool) {
            super.setEditing(editing, animated: animated)
            if let indexPaths = collectionView?.indexPathsForVisibleItems {
                for indexPath in indexPaths {
                    if let cell = collectionView?.cellForItem(at: indexPath) as? RecipeCollectionViewCell {
                        cell.isEditing = editing
                    }
                }
            }
        }
    
    
    
    
    // MARK: UICollectionViewDelegate
    
    /*
     // Uncomment this method to specify if the specified item should be highlighted during tracking
     override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment this method to specify if the specified item should be selected
     override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
     override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
     
     }
     */
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.size.width - 48, height: 300)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 24
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 12, left: 0, bottom: 12, right: 0)
    }
    
}

//extension RecipeCollectionViewController: RecipeCellDelegate {
//    func delete(indx: RecipeCollectionViewCell) {
//        if let indexPath = collectionView?.indexPath(for: indx) {
//            recipes.remove(at: indexPath.item)
//            collectionView?.deleteItems(at: [indexPath])
//
//            CoreDataManager.shared.persistentContainer.viewContext.delete(recipes[indexPath.item])
//            CoreDataManager.shared.saveContext()
//        }
//
//    }
//}
//
//
//
////    func delete(cell: RecipeCollectionViewCell) {
////        if let indexPath = collectionView?.indexPath(for: cell) {
////            let recipe = recipes[indexPath.item]
////            recipes.remove(at: indexPath.item)
////
////            collectionView?.deleteItems(at: [indexPath])
////
////            CoreDataManager.shared.persistentContainer.viewContext.delete(recipe)
////            CoreDataManager.shared.saveContext()
////        }
////    }
//
//

