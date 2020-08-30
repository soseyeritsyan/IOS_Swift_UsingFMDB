//
//  SignUpViewController.swift
//  UsingFMDB
//
//  Created by Sose Yeritsyan on 4/28/20.
//  Copyright © 2020 Sose Yeritsyan. All rights reserved.
//

import UIKit
import FMDB

class SignUpViewController: UIViewController, UITextFieldDelegate {

    
    @IBOutlet weak var firstNametxt: UITextField!
    @IBOutlet weak var lastNametxt: UITextField!
    @IBOutlet weak var birthDaytxt: UITextField!
    @IBOutlet weak var heightTxt: UITextField!
    @IBOutlet weak var weightTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var phoneTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    
    @IBOutlet weak var isMale: UISegmentedControl!
    @IBOutlet weak var signUpButton: UIButton!
    
    
    var bdate = Date()
    var buttonText = "Sign up"
    
    var user = User()
    
    private var datePicker:UIDatePicker?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dismissKey()
        
        signUpButton.setTitle(buttonText, for: .normal)
        firstNametxt.addTarget(self, action:  #selector(textFieldDidChange(_:)),  for:.editingChanged )
        lastNametxt.addTarget(self, action:  #selector(textFieldDidChange(_:)),  for:.editingChanged )
        birthDaytxt.addTarget(self, action:  #selector(textFieldDidChange(_:)),  for:.editingChanged )
        heightTxt.addTarget(self, action:  #selector(textFieldDidChange(_:)),  for:.editingChanged )
        weightTxt.addTarget(self, action:  #selector(textFieldDidChange(_:)),  for:.editingChanged )
        emailTxt.addTarget(self, action:  #selector(textFieldDidChange(_:)),
            for:.editingChanged )
        phoneTxt.addTarget(self, action:  #selector(textFieldDidChange(_:)),
            for:.editingChanged )
        passwordTxt.addTarget(self, action:  #selector(textFieldDidChange(_:)), for:.editingChanged )

        
        if buttonText == "Sign up" {
            signUpButton.isEnabled = false
            emailTxt.isUserInteractionEnabled = true
            
        } else {
            firstNametxt.text = user.firstname
            lastNametxt.text = user.lastname
            birthDaytxt.text = user.birthday
            heightTxt.text = String(user.height)
            weightTxt.text = String(user.weight)
            emailTxt.isUserInteractionEnabled = false
            
            emailTxt.text = user.email
            phoneTxt.text = user.phone
            passwordTxt.text = user.password
        }
        
        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .date
        birthDaytxt.inputView = datePicker
        datePicker?.addTarget(self, action: #selector(dateChanged(datePicker:)), for: .valueChanged)
            
        
        heightTxt.keyboardType = UIKeyboardType.numberPad
        weightTxt.keyboardType = UIKeyboardType.numberPad
        phoneTxt.keyboardType = UIKeyboardType.numberPad
        emailTxt.keyboardType = UIKeyboardType.emailAddress
        passwordTxt.isSecureTextEntry = true
        
    }
    @objc func dateChanged(datePicker: UIDatePicker) {
        bdate = datePicker.date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        birthDaytxt.text = dateFormatter.string(from: datePicker.date)
    }

    @objc func textFieldDidChange(_ sender: UITextField) {
        if firstNametxt.text?.isEmpty == true || lastNametxt.text?.isEmpty == true || birthDaytxt.text?.isEmpty == true || heightTxt.text?.isEmpty == true || weightTxt.text?.isEmpty == true || emailTxt.text?.isEmpty == true || phoneTxt.text?.isEmpty == true || passwordTxt.text?.isEmpty == true {
            
               signUpButton.isEnabled = false
            
           } else{
            
                signUpButton.isEnabled = true
           }
       }
    
    func isValidEmail(_ emailID:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: emailID)
    }
    
    
    @IBAction func signUpClick(_ sender: UIButton) {
        
        user.firstname = firstNametxt.text!
        user.lastname = lastNametxt.text!
        user.birthday = birthDaytxt.text!
        user.ismale = isMale.selectedSegmentIndex
        user.height = Int(heightTxt.text!)!
        user.weight = Int(weightTxt.text!)!
        user.email = emailTxt.text!
        user.phone = phoneTxt.text!
        user.password = passwordTxt.text!
        
        if buttonText == "Sign up" {
            if isValidEmail(emailTxt.text!) {
                if FMDBDatabaseModel.getInstance().findUserByEmail(email: emailTxt.text) != nil {
                    let alert = UIAlertController(title: "Registracion fault", message:"This email \(emailTxt.text!) is already exist. Try with different email." , preferredStyle: .alert)

                    alert.addAction(UIAlertAction(title: "OKAY", style: .default, handler: nil))

                    self.present(alert, animated: true)
            
                } else {
                    FMDBDatabaseModel.getInstance().InsertData(user: user)
            
                    let alert = UIAlertController(title: "Registracion success", message:"You registered successfully" , preferredStyle: .alert)

                    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                        self.navigationController?.popToRootViewController(animated: true)
                }))

                self.present(alert, animated: true)
                }
            } else {
                let alert =
                    UIAlertController(title: "Registracion fault", message: "This email is not valid" , preferredStyle: .alert)

                alert.addAction(UIAlertAction(title: "OKAY", style: .default, handler: nil))

                self.present(alert, animated: true)
            }
            
        } else {
            
            FMDBDatabaseModel.getInstance().updateRecode(user: user)
            self.navigationController?.popToRootViewController(animated: true)

        }
        
    }
}


extension UIViewController {
    func dismissKey() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer( target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
