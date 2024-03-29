//
//  HypeTableViewController.swift
//  Hype27
//
//  Created by Albert Yu on 7/9/19.
//  Copyright © 2019 AlbertLLC. All rights reserved.
//

import UIKit

class HypeTableViewController: UITableViewController, UITextFieldDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }

    // MARK: - Table view data source

    @IBAction func addButtonTapped(_ sender: Any) {
        presentHypeAlert()
    }
    
    func presentHypeAlert() {
        let alertController = UIAlertController(title: "Get Hype", message: "What is hype may never die", preferredStyle: .alert)
        
        alertController.addTextField { (textField) -> Void in
            textField.placeholder = "Hype has a limit of 45 characters."
            textField.autocorrectionType = .yes
            textField.autocapitalizationType = .sentences
            textField.delegate = self
        }
        let addHypeAction = UIAlertAction(title: "Send", style: .default) { (_) in
            guard let hypeText = alertController.textFields?.first?.text else {return}
            if hypeText != "" {
                HypeController.sharedInstance.saveHype(with: hypeText, completion: { (success) in
                    if success {
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    }
                })
            }
        }
        let cancelAction = UIAlertAction(title:"Cancel", style: .destructive)
        
        alertController.addAction(addHypeAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func loadData() {
        HypeController.sharedInstance.fetchDemHypes { (success) in
            if success {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return HypeController.sharedInstance.hypes.count
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "hypeCell", for: indexPath)
        let hype = HypeController.sharedInstance.hypes[indexPath.row]
        cell.textLabel?.text = hype.hypeText
        cell.detailTextLabel?.text = "\(hype.timestamp)"
        

        return cell
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */



}
