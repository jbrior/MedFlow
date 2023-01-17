//
//  SecondVC.swift
//  MedFlow
//
//  Created by Colony Of Mercy on 12/27/22.
//

import UIKit

class SecondVC: UIViewController {
    
    var personPassed = People()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = personPassed.name
        let history = personPassed.history!
        var index = 1
        for i in history {
            print("\(index). \(i.capitalized)")
            index += 1
        }
    }
}
