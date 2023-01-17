//
//  ViewController.swift
//  MedFlow
//
//  Created by Colony Of Mercy on 12/27/22.
//

import UIKit
import FirebaseDatabase

class ViewController: UIViewController {
    
    // Storyboard Outlets
    @IBOutlet var tblView: UITableView!
    
    // Global Variables
    var personSelected = People()
    var ref: DatabaseReference!
    var residentsArray = [People]()
    var selectedRows = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        tblView.delegate = self
        tblView.dataSource = self
        tblView.isHidden = true
        ref = Database.database().reference()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getData()
    }
    
    private func generateUUID() -> String {
        return UUID().uuidString
    }
    
    private func generateCurrentTimeStamp () -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy hh:mm"
        return (formatter.string(from: Date()) as NSString) as String
    }
    
    func getData() {
        residentsArray = []
        ref.child("residents").getData(completion: { error, snapshot in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            if let value = snapshot?.value {
                let data = value as! [String:Any]
                var keyArray = [String]()
                for i in data.keys {
                    keyArray.append(i)
                }
                for i in keyArray {
                    let x = data[i] as! [String:Any]
                    self.residentsArray.append(People(id: x["id"] as? String,
                                                      name: (x["name"] as? String)?.capitalized,
                                                      meds: x["meds"] as? [String],
                                                      history: x["history"] as? [String]))
                }
            } else {
                print("No data available from snapshot!")
            }
            self.tblView.isHidden = false
            self.tblView.reloadData()
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "fromFirstToSecond", let svc = segue.destination as? SecondVC {
            svc.personPassed = personSelected
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return residentsArray.count
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        header.textLabel?.textColor = UIColor.gray
        header.textLabel?.font = UIFont.boldSystemFont(ofSize: 30)
        header.textLabel?.frame = header.bounds
        header.textLabel?.textAlignment = .center
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60.0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Colony Residents/Disciples"
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        cell.textLabel?.textColor = .blue
        cell.textLabel?.font = UIFont.systemFont(ofSize: 25)
        cell.textLabel?.text = residentsArray[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tblView.deselectRow(at: indexPath, animated: true)
        personSelected = residentsArray[indexPath.row]
        performSegue(withIdentifier: "fromFirstToSecond", sender: self)
    }
}
