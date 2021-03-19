//
//  ViewController.swift
//  Rx
//
//  Created by Ekaterina Stepanova on 02.02.21.
//

import UIKit
import Bond
import ReactiveKit

class ViewController: UIViewController {

    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var feedbackLabel: UILabel!
    @IBOutlet weak var sendButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let emailRegEx = try! NSRegularExpression(pattern: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}")
        
        combineLatest(loginTextField.reactive.text, passwordTextField.reactive.text) { [weak self] email, pass in
            
            let range = NSRange(location: 0, length: email?.utf16.count ?? 0)
            let emailIsOk = (emailRegEx.firstMatch(in: email ?? "", options: [], range: range) != nil)
            let passIsOk = (pass?.count ?? 0 > 5)
            
            if !emailIsOk {
                self!.feedbackLabel.text = "Введите корректный e-mail"
            } else if !passIsOk {
                self!.feedbackLabel.text = "Пароль должен содержать не меньше 6 символов"
            } else {
                self!.feedbackLabel.text = "Отлично!"
            }
            
            return emailIsOk && passIsOk
          }
        
          .bind(to: sendButton.reactive.isEnabled)
          .dispose(in: bag)
    }


}

