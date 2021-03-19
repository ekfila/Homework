//
//  ViewControllerC.swift
//  Rx
//
//  Created by Ekaterina Stepanova on 17.02.21.
//

import UIKit
import Bond

class ViewControllerC: UIViewController {
    
    @IBOutlet weak var removeButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    let initArr = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "M", "O", "P", "Q", "R", "S"]
    let listOfNames = MutableObservableArray(["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "M", "O", "P", "Q", "R", "S"])
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        listOfNames.map{ $0.collection.count != 0 }.bind(to: removeButton.reactive.isEnabled)
        
        listOfNames.bind(to: tableView) { (dataSourse, indexPath, tableView) -> UITableViewCell in
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell") as! TableViewCell
            cell.label.text = dataSourse[indexPath.row]
            
            return cell
        }
        
    }
    
    @IBAction func add(_ sender: Any) {
        let randomInt = Int.random(in: 0..<initArr.count)
        listOfNames.insert(initArr[randomInt], at: 0)
    }
    
    @IBAction func remove(_ sender: Any) {
            listOfNames.removeLast()
    }
}
