//
//  iPad Uses.swift
//  Portfolio1 Mobile
//
//  Created by George Robinson on 15/03/2019.
//  Copyright © 2019 George Robinson. All rights reserved.
//

import UIKit
import CoreData

class iPad_Uses: UIViewController {

    var person: objects!
    var q2: String!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        person.q2 = q2
        
        if segue.destination is lastQuestion
        {
            let vc = segue.destination as? lastQuestion
            //        vc?.username = "Testing"
            vc?.person = person
        }
    }

    @IBAction func games(_ sender: UIButton) {
        q2 = "games"
        performSegue(withIdentifier: "lq", sender: self)
        print(q2!)
    }
//
    @IBAction func internet(_ sender: Any) {
        q2 = "internet"
        performSegue(withIdentifier: "lq", sender: self)
        print(q2!)
    }

    @IBAction func work(_ sender: Any) {
        q2 = "work"
        performSegue(withIdentifier: "lq", sender: self)
        print(q2!)
    }

    @IBAction func social(_ sender: Any) {
        q2 = "social media"
        performSegue(withIdentifier: "lq", sender: self)
        print(q2!)
    }

    @IBAction func other(_ sender: Any) {
        q2 = "other"
        performSegue(withIdentifier: "lq", sender: self)
        print(q2!)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
