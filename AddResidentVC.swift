//
//  AddResidentVC.swift
//  MedFlow
//
//  Created by Colony Of Mercy on 12/30/22.
//

import UIKit

class AddResidentVC: UIViewController {
    
    @IBOutlet var closeBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
}
