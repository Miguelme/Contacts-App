//
//  AddContactViewController.swift
//  Contacts
//
//  Created by Miguel Fagundez on 7/26/17.
//  Copyright © 2017 Miguel Fagundez. All rights reserved.
//

import UIKit

class AddContactViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var nameFld: UITextField!
    @IBOutlet weak var ageFld: UITextField!
    @IBOutlet weak var emailFld: UITextField!
    @IBOutlet weak var addBtn: UIButton!
    
    var name = ""
    var age = 0
    var email = ""
    var editMode = false
    var index = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        _ = [nameFld, ageFld, emailFld].map {$0.addTarget(self, action: #selector(textChanged), for: .editingChanged) }
        addBtn.isHidden = !editMode
        addBtn.setTitle(editMode ? "Edit Contact" : "Add Contact", for: .normal)
        
        if editMode {
            nameFld.text = name
            ageFld.text = String(describing:age)
            emailFld.text = email
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addContact(_ sender: Any) {
        if editMode {
            let contact = getContact()
            ContactsViewModel.updateContact(contact: contact, index: index)
            dismiss(animated: true, completion: nil)
        } else {
            let contact = getContact()
            ContactsViewModel.addContact(contact: contact)
            dismiss(animated: true, completion: nil)
        }
        
    }
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    func textChanged() {
        let fieldArray: [UITextField] = [nameFld, ageFld, emailFld]
        let isValidData = fieldArray.reduce(true) { (acc, fld) in acc && fld.text != nil && fld.text != ""}
        addBtn.isHidden = !isValidData
    }
    
    private func getContact() -> Contact {
        return Contact(name: nameFld.text!, age: Int(ageFld.text!)!, email: emailFld.text!)
    }

}
