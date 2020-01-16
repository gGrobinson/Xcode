//
//  question1.swift
//  Portfolio1 Mobile
//
//  Created by George Robinson on 15/03/2019.
//  Copyright © 2019 George Robinson. All rights reserved.
//

import UIKit
import CoreData

class question1: UIViewController {
    
    var person: objects!
    var q1: String!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        person.q1 = q1
        
        if segue.destination is __5
        {
            let vc = segue.destination as? __5
            //        vc?.username = "Testing"
            vc?.person = person
        }
        if segue.destination is iPad_Uses{
            let vc = segue.destination as? iPad_Uses
            vc?.person = person
        }
    }
    
    @IBAction func Yes(_ sender: Any) {
        q1 = "Yes"
        performSegue(withIdentifier: "uses", sender: self)
        print(q1!)
    }
    
    @IBAction func No(_ sender: Any) {
        q1 = "No"
//        savingData()
        performSegue(withIdentifier: "rating", sender: self)
         print(q1!)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        alert(title: "Proceed?", message: " ")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    func alert(title:String, message:String){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        //Create button
        alertController.addAction(UIAlertAction(title: "Yes", style: .default, handler: nil))
        
        alertController.addAction(UIAlertAction(title: "No", style: .default, handler: { _ in self.performSegue(withIdentifier: "home", sender: self)        }))
        
        self.present(alertController, animated: true, completion: nil)
    }
}

