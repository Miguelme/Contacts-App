//
//  ContactsViewModel.swift
//  Contacts
//
//  Created by Miguel Fagundez on 7/26/17.
//  Copyright © 2017 Miguel Fagundez. All rights reserved.
//

import UIKit

struct ContactsViewModel {

    static var list : [Contact] = []
    
    static func addContact(contact: Contact) {
        list.append(contact)
    }
    
    static func removeContact(contact: Contact) {
        let indexToDelete = list.index(of: contact)
        if let indexValue = indexToDelete {
            list.remove(at: indexValue)
        }
    }
    
    static func updateContact(contact: Contact, index: Int) {
        if index < list.count {
            list[index] = contact
        }
    }
    
    static func getContact(index: Int) -> Contact? {
        return index < list.count ? list[index] : Optional.none
    }
    
    static func getListOfContacts() -> [Contact] {
        return list
    }
}
