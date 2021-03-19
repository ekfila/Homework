//
//  ViewControllerF.swift
//  Rx
//
//  Created by Ekaterina Stepanova on 19.03.21.
//

import UIKit
import Bond
import ReactiveKit

class ViewControllerF: UIViewController {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var removeButton: UIButton!
    @IBOutlet weak var addButton: UIButton!
    
    let initArr = ["Alla", "Barbara", "Cindy", "Darja", "Elene", "Filipp", "Gena", "Helen", "Irina", "Jasmin", "Alina", "Alena", "Anna", "Aleftina", "Alex", "Alexander", "Alexey", "Alan", "Gera", "Elon"]
    let listOfNames = MutableObservableArray(["Alla", "Barbara", "Cindy", "Darja", "Elene", "Filipp", "Gena", "Helen", "Irina", "Jasmin", "Alina", "Alena", "Anna", "Aleftina", "Alex", "Alexander", "Alexey", "Alan", "Gera", "Elon"])
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        listOfNames.map{ $0.collection.count != 0 }.bind(to: removeButton.reactive.isEnabled)
        
        textField.reactive.text
            .debounce(for: 2.0)
            .combineLatest(with: listOfNames)
            {text, names -> [String] in
            var filterNames: [String] = []
            for name in names.collection {
                if name[..<name.index(name.startIndex, offsetBy: text!.count)] == text! {
                    filterNames.append(name)
                }
            }
            return filterNames
        }.bind(to: tableView) { (dataSourse, indexPath, tableView) -> UITableViewCell in

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
