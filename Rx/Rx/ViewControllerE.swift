//
//  ViewControllerE.swift
//  Rx
//
//  Created by Ekaterina Stepanova on 19.03.21.
//

import UIKit
import Bond
import ReactiveKit

class ViewControllerE: UIViewController {

    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        combineLatest(button1.reactive.tap, button2.reactive.tap) {
            _,_ in
            return("ракета запущена")
        }.bind(to: label.reactive.text)

    }
    

}
