//
//  Contact.swift
//  Contacts
//
//  Created by Miguel Fagundez on 7/26/17.
//  Copyright © 2017 Miguel Fagundez. All rights reserved.
//

import UIKit

class Contact: NSObject {

    var name: String?
    var age: Int
    var email: String?
    
    init(name: String, age: Int, email: String) {
        self.name = name
        self.age = age
        self.email = email
    }
}
