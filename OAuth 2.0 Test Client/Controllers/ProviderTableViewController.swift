//
//  ProviderTableViewController.swift
//  OAuth 2.0 Test Client
//
//  Created by Thorin on 2018-01-02.
//  Copyright © 2018 SOA Architects Inc. All rights reserved.
//

import UIKit
import CoreData

class ProviderTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {

//    var providerNames = ["Hapi OAuth", "Hapi OAuth Localhost", "Demo"]
//    var providerDomain = ["https://foo.com", "https://localhost:8443/", "https://localhost:8443/"]
//    var providerCompany = ["SOA Architects", "SOA Architects", "Facebook"]
//    var providerSelected = Array(repeating: false, count: 3)
    var providers: [ProviderMO] = []
    var fetchResultController: NSFetchedResultsController<ProviderMO>!
    
    @IBOutlet var emptyProvidersView: UIView!
    
    @IBAction func unwindToHome(segue: UIStoryboardSegue) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Adjust table width on iPad
        tableView.cellLayoutMarginsFollowReadableWidth = true
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        tableView.backgroundView = emptyProvidersView
        tableView.backgroundView?.isHidden = true
        
        // Fetch data from data store
        let fetchRequest: NSFetchRequest<ProviderMO> = ProviderMO.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
            let context = appDelegate.persistentContainer.viewContext
            fetchResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
            fetchResultController.delegate = self
            
            do {
                try fetchResultController.performFetch()
                if let fetchedObjects = fetchResultController.fetchedObjects {
                    providers = fetchedObjects
                }
            } catch {
                print(error)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        if providers.count > 0 {
            tableView.backgroundView?.isHidden = true
            tableView.separatorStyle = .singleLine
        } else {
            tableView.backgroundView?.isHidden = false
            tableView.separatorStyle = .none
        }
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return providers.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! ProviderTableViewCell
        
        let provider = providers[indexPath.row] as ProviderMO
        // Configure the cell...
        cell.nameLabel?.text = provider.name!
        cell.domainLabel?.text = provider.authorizationEndpoint!.absoluteString
        cell.providerLabel?.text = provider.company!
        cell.thumbnailImageView?.image = UIImage(named: "icons8-server")
        // Because of cell re-use, a new cell could have the checked accessory type already added
        if provider.isSelected {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        
        return cell
    }
    
    /*override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            providerNames.remove(at: indexPath.row)
            providerDomain.remove(at: indexPath.row)
            providerCompany.remove(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }*/
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") {
            (action, sourceView, completionHandler) in
            // Delete the row from the data source
//            self.providerNames.remove(at: indexPath.row)
//            self.providerDomain.remove(at: indexPath.row)
//            self.providerCompany.remove(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            // Call completion handler to dismiss the action button
            completionHandler(true)
        }
        
        let detailsAction = UIContextualAction(style: .normal, title: "Details") {
            (action, sourceView, completionHandler) in
            
            let providerDetailsVC = self.storyboard?.instantiateViewController(withIdentifier: "ProviderDetails") as! ProviderDetailsViewController
            providerDetailsVC.providerName = self.providers[indexPath.row].name!
            self.navigationController?.pushViewController(providerDetailsVC, animated: true)
            // Call completion handler to dismiss the action button
            completionHandler(true)
        }
        
        let swipeConfiguration = UISwipeActionsConfiguration(actions: [deleteAction, detailsAction])
        return swipeConfiguration
    }
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            if let newIndexPath = newIndexPath {
                tableView.insertRows(at: [newIndexPath], with: .fade)
            }
        case .delete:
            if let newIndexPath = newIndexPath {
                tableView.deleteRows(at: [newIndexPath], with: .fade)
            }
        case .update:
            if let newIndexPath = newIndexPath {
                tableView.reloadRows(at: [newIndexPath], with: .fade)
            }
        default:
            tableView.reloadData()
        }
        
        if let fetchedObjects = controller.fetchedObjects {
            providers = fetchedObjects as! [ProviderMO]
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    /*override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Create an option menu as an action sheet
        let optionMenu = UIAlertController(title: nil, message: "What do you want to do?", preferredStyle: .actionSheet)
        // For iPad
        if let popoverController = optionMenu.popoverPresentationController {
            if let cell = tableView.cellForRow(at: indexPath) {
                popoverController.sourceView = cell
                popoverController.sourceRect = cell.bounds
            }
        }
        // Add actions to the menu
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        optionMenu.addAction(cancelAction)
        
        
        // If provider is already selected, offer an option to de-select it
        if self.providerSelected[indexPath.row] {
            let deselectAction = UIAlertAction(title: "De-select", style: .default, handler: {
                (action:UIAlertAction!) -> Void in
                
                let cell = tableView.cellForRow(at: indexPath)
                cell?.accessoryType = .none
                self.providerSelected[indexPath.row] = false
            })
            optionMenu.addAction(deselectAction)
        } else {
            let selectAction = UIAlertAction(title: "Select Provider", style: .default, handler: {
                (action:UIAlertAction!) -> Void in
                
                let cell = tableView.cellForRow(at: indexPath)
                cell?.accessoryType = .checkmark
                self.providerSelected[indexPath.row] = true
            })
            optionMenu.addAction(selectAction)
        }
        
        // Display the menu
        present(optionMenu, animated: true, completion: nil)
    }*/

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
