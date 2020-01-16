//
//  1-5.swift
//  Portfolio1 Mobile
//
//  Created by George Robinson on 15/03/2019.
//  Copyright © 2019 George Robinson. All rights reserved.
//

import UIKit
import CoreData

class __5: UIViewController {
    
    var person: objects!
    var q1: String!
    var q2: String!
    
    @IBOutlet weak var rating: UILabel!
    
    @IBAction func valChanged(_ sender: UISlider) {
        rating.text = String(Int(sender.value))
        q2 = rating.text

    }
    
    @IBAction func next(_ sender: Any) {
        performSegue(withIdentifier: "lastQ", sender: self)
        print(q2!)
    }
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}
