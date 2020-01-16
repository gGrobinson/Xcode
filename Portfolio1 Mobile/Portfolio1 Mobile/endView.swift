//
//  endView.swift
//  Portfolio1 Mobile
//
//  Created by George Robinson on 20/03/2019.
//  Copyright © 2019 George Robinson. All rights reserved.
//

import UIKit
import CoreData

class endView: UIViewController {
    
    var person: objects!
    var q1: String!
    var q2: String!
    var q3: String!

    @IBOutlet weak var statusLabel: UILabel!
    
    @IBAction func retBtn(_ sender: Any) {
          performSegue(withIdentifier: "back", sender: self)

    }
    
    @IBAction func saveBtn(_ sender: Any) {
        savingData()
    }
    
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
    
    
    func savingData(){
        //start of setting up core data
        //As we know that container is set up in the AppDelegates so we need to refer that container.
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        //We need to create a context from this container
        let managedContext = appDelegate.persistentContainer.viewContext
        
        //Now let’s create an entity and new user records.
        let userEntity = NSEntityDescription.entity(forEntityName: "Users", in: managedContext)!
        
        //here adding 5 data with loop - replace this with your textfields
        let user = NSManagedObject(entity: userEntity, insertInto: managedContext)
        user.setValue(person.name, forKey: "name")
        user.setValue(person.age, forKey: "age")
        user.setValue(person.q1, forKey: "q1")
        user.setValue(person.q2, forKey: "q2")
        user.setValue(person.q3, forKey: "q3")
        
        do {
            try managedContext.save()
            statusLabel.text="Data saved"
            
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
            statusLabel.text="Error!"
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
}
