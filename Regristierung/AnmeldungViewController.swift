//
//  ViewController.swift
//  Regristierung
//
//  Created by Stefan Schreiber on 28.11.22.
//

import UIKit

class AnmeldungViewController: UIViewController  {
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var geburtstag: UITextField!
    @IBOutlet weak var groesse: UITextField!
    @IBOutlet weak var gewicht: UITextField!
    @IBOutlet weak var geschlecht: UITextField!
    let geschlechter = ["weiblich", "männlich", "divers"]
    let geschlechterPicker = UIPickerView()
    let datePicker = UIDatePicker()
    
    
    @IBOutlet weak var register: UIButton!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        keyboardDismissable()
        createDataPicker()
        
        
        register.isEnabled = true
        email.keyboardType = .emailAddress
        groesse.keyboardType = .numberPad
        gewicht.keyboardType = .numberPad
        //geburtstag.keyboardType = bool
        //geschlecht.keyboardType =
        
        
        name.delegate = self
        email.delegate = self
        geburtstag.delegate = self
        groesse.delegate = self
        gewicht.delegate = self
        geschlecht.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize =  (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
        {if self.view.frame.origin.y == 0 && (email.isFirstResponder) {
            self.view.frame.origin.y -= keyboardSize.height
        }
        }
    }
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }    // Tastatur ausserhalb
    @objc func dismissKeyboardTouchOutside() {
        self.view.endEditing(true)
    }
    
    func keyboardDismissable() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboardTouchOutside))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
    }
    //Date Picker
    
    @objc func  datepressed() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.mm.yyyy"
        geburtstag.text = dateFormatter.string(from: datePicker.date)
        geschlecht.becomeFirstResponder()
        
    }
    
    func createDataPicker() {
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date
        geburtstag.inputView = datePicker
        geburtstag.inputAccessoryView = createToolbar()
        
        //Toolbar
    }
    
    func createToolbar() -> UIToolbar {
        let toolBar = UIToolbar()
        
        toolBar.sizeToFit()
        let button = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(datepressed))
        toolBar.setItems([button], animated: true)
        return toolBar
    }
    
    
    
}
//Textfelder

extension AnmeldungViewController: UITextFieldDelegate {
    func textFieldShoudReturn(_ textFeld: UITextField) -> Bool {
        switch textFeld {
        case name:
            geburtstag.becomeFirstResponder()
        default: self.view?.endEditing(true)
        }
        return true
    }
}




extension AnmeldungViewController: UITextFieldDelegate {
    func textFieldShouldReturn( _ textField: UITextField) -> Bool {
        self.view.endEditing(true)
    }
    
}
