//
//  SignInViewController.swift
//  UsingFMDB
//
//  Created by Sose Yeritsyan on 4/28/20.
//  Copyright © 2020 Sose Yeritsyan. All rights reserved.
//

import UIKit
import FMDB
class SignInViewController: UIViewController {
    
   // let context = CoreDataManager.sharedManager.persistentContainer.viewContext

    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dismissKey()
        emailTextField.keyboardType = UIKeyboardType.emailAddress
        passwordTextField.isSecureTextEntry = true

    }
    @IBAction func trySignIn(_ sender: UIButton) {
        
        
        let message = FMDBDatabaseModel.getInstance().tryLogIn(email: emailTextField.text, password: passwordTextField.text)

        
        let alert = UIAlertController(title: "User info", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true)
        
    }
}

