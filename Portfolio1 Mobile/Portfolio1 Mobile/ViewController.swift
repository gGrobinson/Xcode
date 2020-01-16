//
//  ViewController.swift
//  Portfolio1 Mobile
//
//  Created by George Robinson on 14/03/2019.
//  Copyright © 2019 George Robinson. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    var person: objects!
    
    //do core data at last screen
    @IBOutlet weak var nameText: UITextField!

    @IBOutlet weak var ageText: UITextField!
    
    private var agePicker: UIDatePicker?
    
    @IBOutlet weak var statusLabel: UILabel!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.destination is question1
        {
            let vc = segue.destination as? question1
            //        vc?.username = "Testing"
            vc?.person = person
        }
    }
    @IBAction func login(_ sender: Any) {
        performSegue(withIdentifier: "loginP", sender: self)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        // datepicker
        agePicker = UIDatePicker()
        var dateComponents = DateComponents()
        let calender = Calendar.init(identifier: .gregorian)
        dateComponents.year = -90
        let minDate = calender.date(byAdding: dateComponents, to: Date())
        dateComponents.year = -65
        let maxDate = calender.date(byAdding: dateComponents, to: Date())
        agePicker?.maximumDate = maxDate
        agePicker?.minimumDate = minDate
        agePicker?.datePickerMode = .date
        agePicker?.addTarget(self, action: #selector(ViewController.ageChanged(agePicker:)), for: .valueChanged)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(ViewController.viewTapped(gestureRecognizer:)))
        view.addGestureRecognizer(tapGesture)
        ageText.inputView = agePicker
        
    }

    @objc func viewTapped(gestureRecognizer: UITapGestureRecognizer){
        view.endEditing(true)
    }
    
    @IBAction func startBtn(_ sender: Any) {
        //savingData()
        person = objects(name: nameText.text!, age: ageText.text ?? "2")
        performSegue(withIdentifier: "p1", sender: self)
        print(nameText!, ageText!)
    }
    
    @IBAction func retriveBtn(_ sender: Any) {
    }
    
    @objc func ageChanged(agePicker: UIDatePicker){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/YYYY"
        ageText.text  = dateFormatter.string(from: agePicker.date)
        view.endEditing(true)
    }

}

