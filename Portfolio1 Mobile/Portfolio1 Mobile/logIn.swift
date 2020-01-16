//
//  logIn.swift
//  Portfolio1 Mobile
//
//  Created by George Robinson on 29/03/2019.
//  Copyright © 2019 George Robinson. All rights reserved.
//

import UIKit

class logIn: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBOutlet weak var user: UITextField!

    @IBOutlet weak var password: UITextField!
    
    @IBAction func login(_ sender: Any){
        var username: String?
        var passwordEnter: String?
        
        username = "Hello"
        passwordEnter = "results"
        
        if (user.text == username && password.text == passwordEnter)
        {
            performSegue(withIdentifier: "results", sender: self)
        }
    }
}
