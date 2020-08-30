//
//  User.swift
//  UsingFMDB
//
//  Created by Sose Yeritsyan on 6/17/20.
//  Copyright © 2020 Sose Yeritsyan. All rights reserved.
//

import Foundation
struct User {
    var firstname: String
    var lastname: String
    var birthday: String
    var ismale: Int
    var height: Int
    var weight: Int
    var phone: String
    var email: String
    var password: String
    
    init() {
        firstname = String()
        lastname = String()
        birthday = String()
        ismale = Int()
        height = Int()
        weight = Int()
        phone = String()
        email = String()
        password = String()
    }
    
    init(firstname: String, lastname: String, birthday: String, ismale: Int, height: Int, weight: Int, phone: String, email: String, password: String){
        
        self.firstname = firstname
        self.lastname = lastname
        self.birthday = birthday
        self.ismale = ismale
        self.height = height
        self.weight = weight
        self.phone = phone
        self.email = email
        self.password = password
        
    }
}
