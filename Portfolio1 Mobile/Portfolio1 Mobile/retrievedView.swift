//
//  retrievedView.swift
//  Portfolio1 Mobile
//
//  Created by George Robinson on 20/03/2019.
//  Copyright © 2019 George Robinson. All rights reserved.
//

import UIKit
import CoreData

class retrievedView: UIViewController{
    
    var person: objects!
    var q1: String!
    var q2: String!
    var q3: String!

    @IBOutlet weak var nameText: UITextField!
    
    @IBOutlet weak var ageText: UITextField!
    
    @IBOutlet weak var q1Text: UITextField!
    
    @IBOutlet weak var q2Text: UITextField!
    
    @IBOutlet weak var q3Text: UITextField!
    
    @IBAction func search(_ sender: Any) {
        requestData()
    }
    
    @IBAction func deleteBtn(_ sender: Any) {
        deleteData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func requestData(){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        //We need to create a context from this container
        let managedContext = appDelegate.persistentContainer.viewContext

        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
        request.fetchLimit = 1
        request.predicate = NSPredicate(format: "name = %@", nameText.text!)
        request.sortDescriptors = [NSSortDescriptor.init(key: "name", ascending: false)]
        request.returnsObjectsAsFaults = false
        do{
            let results = try managedContext.fetch(request)
            //is there any info
            for data in results as! [NSManagedObject] {
                // print(data.value(forKey: "id") as! String)
                nameText.text = data.value(forKey:"name") as? String ?? "test"
                ageText.text = data.value(forKey:"age") as? String ?? "test"
                q1Text.text = data.value(forKey:"q1") as? String ?? "test"
                q2Text.text = data.value(forKey:"q2") as? String ?? "test"
                q3Text.text = data.value(forKey:"q3") as? String ?? "test"
            }

        } catch {

            print("Failed")
        }

    }

    func deleteData(){

        //As we know that container is set up in the AppDelegates so we need to refer that container.
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }

        //We need to create a context from this container
        let managedContext = appDelegate.persistentContainer.viewContext

        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Data")
        fetchRequest.predicate = NSPredicate(format: "name = %@")

        do
        {
            if let test = try? managedContext.fetch(fetchRequest){
                for objects in test{
                    managedContext.delete(objects as! NSManagedObject)
                }
            }

            do{
                try managedContext.save()
            }
            catch
            {
                print(error)
            }

        }

    }
}
