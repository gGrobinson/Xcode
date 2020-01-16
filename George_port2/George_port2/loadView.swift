//
//  loadView.swift
//  George_port2
//
//  Created by George Robinson on 28/03/2019.
//  Copyright © 2019 George Robinson. All rights reserved.
//

import UIKit
import CoreData
import Photos
import CoreImage

class loadView: UIViewController {

    var saved: pictures!
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var guess: UILabel!
    @IBOutlet weak var confidence: UILabel!
    @IBOutlet weak var id: UITextField!
    @IBAction func load(_ sender: Any) {
        requestData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func noir(_ sender: Any) {
        let inputImage = CIImage(image: imageView.image!)
        
        //define filter type
        let filter = CIFilter(name: "CIPhotoEffectNoir")
        //edges, blur, filter
        filter?.setDefaults()
        filter?.setValue(inputImage, forKey: kCIInputImageKey)
        
        //output image
        if let outputImage = filter?.outputImage{
            let newImage = UIImage(ciImage: outputImage)
            //newImage = UIImage(ciImage: outputImage)
            //displayImage.image = nil
            imageView.image = newImage
        }
    }
    
    func requestData(){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        //We need to create a context from this container
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        request.fetchLimit = 1
        request.predicate = NSPredicate(format: "id = %@", id.text!)
        request.sortDescriptors = [NSSortDescriptor.init(key: "id", ascending: false)]
        request.returnsObjectsAsFaults = false
        do{
            let results = try managedContext.fetch(request)
            for data in results as! [NSManagedObject] {
                
                id.text = data.value(forKey:"id") as? String
                guess.text = data.value(forKey:"guess") as? String
                confidence.text = data.value(forKey:"confidence") as? String
                imageView.image = UIImage(data: (data.value(forKey: "picture") as? Data)!)
            }
            
        } catch {
            
            print("Failed")
        }
        
    }
    
    //----------------------------------------------------------- filter btn
    
//        var filterName: String?
//    @IBAction func filterBtn(_ sender: UIButton) {
//
//        switch sender.tag{
//        case 0: filterName = "CIGaussianBlur"
//        case 1: filterName = "CIMedianFilter"
//        case 2: filterName = "CIEdges"
//        default: print("no selection")
//        }
//        process()
//    }
//    // `for image filter ----------------------------------- not working
//
//    func process(){
//        //define image file
//
//        //let originalImage = CIImage(image: UIImage?)
//
//        let inputImage = CIImage(image: imageView.image!)
//
//            //define filter type
//            let filter = CIFilter(name: filterName!)
//            //edges, blur, filter
//            filter?.setDefaults()
//            filter?.setValue(inputImage, forKey: kCIInputImageKey)
//
//            //output image
//            if let outputImage = filter?.outputImage{
//                let newImage = UIImage(ciImage: outputImage)
//                //newImage = UIImage(ciImage: outputImage)
//                //displayImage.image = nil
//                imageView.image = newImage
//            }
//        }
//
    
}
