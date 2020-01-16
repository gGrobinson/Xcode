//
//  lastQuestion.swift
//  Portfolio1 Mobile
//
//  Created by George Robinson on 15/03/2019.
//  Copyright © 2019 George Robinson. All rights reserved.
//

import UIKit
import CoreData

class lastQuestion: UIViewController {
    
    var person: objects!
    var q1: String!
    var q2: String!
    var q3: String!

    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        person.q3 = q3
        
        if segue.destination is endView
        {
            let vc = segue.destination as? endView
            //        vc?.username = "Testing"
            vc?.person = person
        }
    }
    

    @IBAction func yes(_ sender: Any) {
        q3 = "yes"
        performSegue(withIdentifier: "last", sender: self)
        print(q3!)
    }
    
    @IBAction func no(_ sender: Any) {
        q3 = "no"
        performSegue(withIdentifier: "last", sender: self)
        print(q3!)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
}
