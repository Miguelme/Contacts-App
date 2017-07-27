//
//  ViewController.swift
//  Contacts
//
//  Created by Miguel Fagundez on 7/26/17.
//  Copyright © 2017 Miguel Fagundez. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var noContactsLbl: UILabel!
    @IBOutlet weak var tableView: UITableView!
    var indexToEdit = -1
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateTableView()
    }
    

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ContactsViewModel.getListOfContacts().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        let contact = ContactsViewModel.getContact(index: indexPath.row)
        cell.textLabel?.text = contact?.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toDetail", sender: self)
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
            let contactToBeDeleted = ContactsViewModel.getContact(index: indexPath.row)
            ContactsViewModel.removeContact(contact: contactToBeDeleted!)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            self.updateTableView()
        }
        
        let edit = UITableViewRowAction(style: .normal, title: "Edit") { (action, indexPath) in
            self.indexToEdit = indexPath.row
            self.performSegue(withIdentifier: "toEdit", sender: self)
            
        }
        
        return [delete, edit]
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetail" {
            if let vc = segue.destination as? DetailViewController {
                vc.index = tableView.indexPathForSelectedRow!.row
            }
        } else if segue.identifier == "toEdit" {
            if let vc = segue.destination as? AddContactViewController {
                let contactToBeEdited = ContactsViewModel.getContact(index: indexToEdit)!
                vc.editMode = true
                vc.name = contactToBeEdited.name!
                vc.age = contactToBeEdited.age
                vc.email = contactToBeEdited.email!
                vc.index = indexToEdit
            }
        } else if segue.identifier == "toAdd" {
            if let vc = segue.destination as? AddContactViewController {
                vc.editMode = false
                vc.index = -1
            }
        }
    }
    
    private func updateTableView() {
        tableView.reloadData()
        tableView.isHidden = tableView.numberOfRows(inSection: 0) == 0
        noContactsLbl.isHidden = !tableView.isHidden
    }
}

