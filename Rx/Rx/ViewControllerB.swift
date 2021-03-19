//
//  ViewControllerB.swift
//  Rx
//
//  Created by Ekaterina Stepanova on 16.02.21.
//

import UIKit
import Bond

class ViewControllerB: UIViewController {
    
    @IBOutlet weak var searchField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        searchField.reactive.text
            .filter {$0!.count > 0}
            .map { text in
                "Отправка запроса для \(text!)"
            }
            .debounce(for: 0.5)
            .observeNext { text in
                print(text)
            }
            .dispose(in: bag)
        
    }
    


}
