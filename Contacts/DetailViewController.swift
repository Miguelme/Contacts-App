//
//  DetailViewController.swift
//  Contacts
//
//  Created by Miguel Fagundez on 7/26/17.
//  Copyright © 2017 Miguel Fagundez. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var ageLbl: UILabel!
    var index = 0
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let contact = ContactsViewModel.getContact(index: index)!
        nameLbl.text = contact.name
        ageLbl.text = String(describing: contact.age)
        emailLbl.text = contact.email
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    @IBAction func goToList(_ sender: Any) {
        dismiss(animated: true, completion:nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toEdit" {
            if let vc = segue.destination as? AddContactViewController {
                vc.editMode = true
                let contact = ContactsViewModel.getContact(index: index)!
                vc.name = contact.name!
                vc.age = contact.age
                vc.email = contact.email!
                vc.index = index
            }
        }
    }
}
