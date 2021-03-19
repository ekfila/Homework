//
//  ViewControllerD.swift
//  Rx
//
//  Created by Ekaterina Stepanova on 19.03.21.
//

import UIKit
import Bond

class ViewControllerD: UIViewController {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var button: UIButton!
    
    let counter = Observable(0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        counter.map{"\($0)"}
            .bind(to: label.reactive.text)

    }
    
    @IBAction func increase(_ sender: Any) {
        counter.value += 1
    }
    
}
