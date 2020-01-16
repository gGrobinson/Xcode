//
//  coreViewController.swift
//  George_port2
//
//  Created by George Robinson on 27/03/2019.
//  Copyright © 2019 George Robinson. All rights reserved.
//

import UIKit
import CoreML
import Vision

class coreViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    var output: UIImage?
    @IBOutlet weak var displayImage: UIImageView!
    @IBOutlet weak var resultDescription: UILabel!

    @IBAction func photoButton(_ sender: Any) {
//        getphoto()
    }
    
//    @IBAction func cameraButton(_ sender: Any) {
//        let imagePicker = UIImagePickerController()
//        imagePicker.delegate = self
//
//        let alertController = UIAlertController(title:nil, message: nil, preferredStyle:.actionSheet)
//        let cancelAction = UIAlertAction(title: "Camera not available", style: .cancel, handler:nil)
//        alertController.addAction(cancelAction)
//
//        if UIImagePickerController.isSourceTypeAvailable(.camera) {
//            let cameraAction = UIAlertAction(title:"Take Photo", style:.default, handler:{(_) in imagePicker.sourceType = .camera
//                self.present(imagePicker,animated: true,completion:nil)
//            })
//            alertController.addAction(cameraAction)
//        }
//
//        present(alertController, animated: true, completion:nil)
//    }
//
//
//    func getphoto(){
//        let imagePicker = UIImagePickerController()
//        imagePicker.delegate = self
//        imagePicker.sourceType = .photoLibrary
//        //imagePicker.sourceType = .camera
//        present(imagePicker, animated: true, completion: nil)
//    }
//
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//        guard let selectedImage = info[.originalImage] as? UIImage
//            else { return }
//        displayImage.image = selectedImage
//        getPrediction(image: selectedImage)
//
//        dismiss(animated: true, completion: nil)
//    }
//
//    func getPrediction(image: UIImage){
//        //let modelFile = ImageClassifier()
//        let modelFile = MobileNet()
//        let model = try! VNCoreMLModel(for: modelFile.model)
//
//        let handler = VNImageRequestHandler(cgImage: image.cgImage!, options: [ : ])
//        let request = VNCoreMLRequest(model: model, completionHandler: findResults)
//
//        try! handler.perform([request])
//    }
//
//    func findResults(request: VNRequest, error: Error?) {
//        guard let results = request.results as? [VNClassificationObservation] else {
//            fatalError("Unable to get results")
//        }
//
//        var bestGuess = ""
//        var bestConfidence: VNConfidence = 0
//
//        for classification in results {
//            if (classification.confidence > bestConfidence) {
//                bestConfidence = classification.confidence
//                bestGuess = classification.identifier
//            }
//        }
//        // labels here
//        resultDescription.text = "Image is: \(bestGuess) with confidence \(bestConfidence) out of 1"
//        //    print("Image is: \(bestGuess) with confidence \(bestConfidence) out of 1")
//    }
//
//    func savingData(){
//        //start of setting up core data
//        //As we know that container is set up in the AppDelegates so we need to refer that container.
//        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
//
//        //We need to create a context from this container
//        let managedContext = appDelegate.persistentContainer.viewContext
//
//        //Now let’s create an entity and new user records.
//        let userEntity = NSEntityDescription.entity(forEntityName: "Users", in: managedContext)!
//
//        //here adding 5 data with loop - replace this with your textfields
//        let user = NSManagedObject(entity: userEntity, insertInto: managedContext)
//        user.setValue(person.name, forKey: "name")
//        user.setValue(person.age, forKey: "age")
//
//        do {
//            try managedContext.save()
//            statusLabel.text="Data saved"
//
//        } catch let error as NSError {
//            print("Could not save. \(error), \(error.userInfo)")
//            statusLabel.text="Error!"
//        }
//
//    }

}
