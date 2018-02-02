//
//  NewProviderController.swift
//  OAuth 2.0 Test Client
//
//  Created by Thorin on 2018-01-11.
//  Copyright © 2018 SOA Architects Inc. All rights reserved.
//

import UIKit
import CoreData

class NewProviderController: UITableViewController, UITextFieldDelegate {

    var provider: ProviderMO!
    
    @IBOutlet var nameTextField: UITextField! {
        didSet {
            nameTextField.tag = 1
            nameTextField.becomeFirstResponder()
            nameTextField.backgroundColor = UIColor(red:0.75, green:0.88, blue:0.98, alpha:1.0)
            nameTextField.delegate = self
        }
    }
    
    @IBOutlet var companyTextField: UITextField! {
        didSet {
            companyTextField.tag = 2
            companyTextField.backgroundColor = UIColor(red:0.75, green:0.88, blue:0.98, alpha:1.0)
            companyTextField.delegate = self
        }
    }
    
    @IBOutlet var authorizationTextField: UITextField! {
        didSet {
            authorizationTextField.tag = 3
            authorizationTextField.backgroundColor = UIColor(red:0.75, green:0.88, blue:0.98, alpha:1.0)
            authorizationTextField.delegate = self
        }
    }
    
    @IBOutlet var tokenTextField: UITextField! {
        didSet {
            tokenTextField.tag = 4
            tokenTextField.backgroundColor = UIColor(red:0.75, green:0.88, blue:0.98, alpha:1.0)
            tokenTextField.delegate = self
        }
    }
    
    @IBOutlet var revocationTextField: UITextField! {
        didSet {
            revocationTextField.tag = 5
            revocationTextField.backgroundColor = UIColor(red:0.75, green:0.88, blue:0.98, alpha:1.0)
            revocationTextField.delegate = self
        }
    }
    
    @IBOutlet var registrationTextField: UITextField! {
        didSet {
            registrationTextField.tag = 6
            registrationTextField.backgroundColor = UIColor(red:0.75, green:0.88, blue:0.98, alpha:1.0)
            registrationTextField.delegate = self
        }
    }
    
    @IBOutlet var userinfoTextField: UITextField! {
        didSet {
            userinfoTextField.tag = 7
            userinfoTextField.backgroundColor = UIColor(red:0.75, green:0.88, blue:0.98, alpha:1.0)
            userinfoTextField.delegate = self
        }
    }
    
    @IBAction func saveButtonTapped(sender: AnyObject) {
        if (nameTextField.text == "" || companyTextField.text == "" ||
            authorizationTextField.text == "" || tokenTextField.text == "") {
            let alertController = UIAlertController(title: "Oops", message: "We can't proceed, because one of the required field is blank.", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(alertAction)
            present(alertController, animated: true, completion: nil)
            
            return
        }
        
        if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
            provider = ProviderMO(context: appDelegate.persistentContainer.viewContext)
            provider.name = nameTextField.text
            provider.company = companyTextField.text
            provider.authorizationEndpoint = URL(string: authorizationTextField.text!)
            provider.tokenEndpoint = URL(string: tokenTextField.text! as! String)
            if let regUrl = registrationTextField.text {
                provider.registrationEndpoint = URL(string: regUrl)
            }
            
            print("Saving data to context... ");
            appDelegate.saveContext()
        }
        
        print("Name: \(nameTextField.text ?? "")")
        print("Name: \(companyTextField.text ?? "")")
        print("Name: \(authorizationTextField.text ?? "")")
        print("Name: \(tokenTextField.text ?? "")")
        print("Name: \(revocationTextField.text ?? "")")
        print("Name: \(registrationTextField.text ?? "")")
        print("Name: \(userinfoTextField.text ?? "")")
        
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorStyle = .none
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let nextTextField = view.viewWithTag(textField.tag + 1) {
            textField.resignFirstResponder()
            nextTextField.becomeFirstResponder()
        }
        
        return true
    }
    
    // MARK: - Table view data source

    /*override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }*/

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

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
