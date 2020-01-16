//
//  ViewController.swift
//  George_port2
//
//  Created by George Robinson on 27/03/2019.
//  Copyright © 2019 George Robinson. All rights reserved.
//

import UIKit
import Photos
import Vision
import AVKit
import CoreData
import CoreLocation

class ViewController: UIViewController,
                        UIImagePickerControllerDelegate,
                        UINavigationControllerDelegate,
                        CLLocationManagerDelegate{
    
    var saved: pictures!
    var id: String!
    var guess: String!
    var confidence: String!
    var picture: Data!
    
    @IBOutlet weak var displayImage: UIImageView!
    @IBOutlet weak var messageLbl: UILabel!
    @IBOutlet weak var resultguess: UILabel!
    @IBOutlet weak var resultConfidence: UILabel!
    @IBOutlet weak var idText: UITextField!
    @IBOutlet weak var statusLabel: UILabel!
    
    @IBAction func loadView(_ sender: Any) {
        performSegue(withIdentifier: "load", sender: self)
    }
    
    @IBAction func photoButton(_ sender: UIButton) {
        getPhoto()
    }
    
    @IBAction func save(_ sender: UIButton) {
        savingData()
        UIImageWriteToSavedPhotosAlbum(displayImage.image!, nil, nil, nil);
    }
    
    @IBAction func Gps(_ sender: Any) {
        performSegue(withIdentifier: "go", sender: self)
        
    }
    
    @IBAction func Lines(_ sender: Any) {
        performSegue(withIdentifier: "lines", sender: self)
    }
    
    func savingData(){
        //start of setting up core data
        //As we know that container is set up in the AppDelegates so we need to refer that container.
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        //We need to create a context from this container
        let managedContext = appDelegate.persistentContainer.viewContext
        
        //Now let’s create an entity and new user records.
        let userEntity = NSEntityDescription.entity(forEntityName: "User", in: managedContext)!

        
        //here adding 5 data with loop - replace this with your textfields
        let user = NSManagedObject(entity: userEntity, insertInto: managedContext)
        user.setValue(idText.text, forKeyPath: "id")
        user.setValue(resultguess.text, forKey: "guess")
        user.setValue(resultConfidence.text, forKey: "confidence")
        user.setValue(picture, forKey: "picture")
        
        do {
            try managedContext.save()
                statusLabel.text="Data saved"
            
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
                statusLabel.text="Error!"
        }
        
    }
    
//--------------------------------------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        // start up  camera source
//        //https://www.youtube.com/watch?v=p6GA8ODlnX0
//
//        let captureSession = AVCaptureSession()
//        captureSession.sessionPreset = .photo
//
//        guard let captureDevice = AVCaptureDevice.default(for: .video) else{return}
//
//        guard let input = try? AVCaptureDeviceInput(device: captureDevice) else{return}
//
//        captureSession.addInput(input)
//        captureSession.startRunning()
//
//        let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
//        view.layer.addSublayer(previewLayer)
//        previewLayer.frame = view.frame
    }
    
//--------------------------------------------------------------------------------
    
    @IBAction func camerBtn(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let cancelAction = UIAlertAction(title: "Camera not available", style: .cancel, handler: nil)
        
        alertController.addAction(cancelAction)
        
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            let cameraAction = UIAlertAction(title: "Take Photo", style: .default, handler: {(_) in imagePicker.sourceType = .camera
                self.present(imagePicker, animated: true, completion: nil)
            })
            alertController.addAction(cameraAction)
        }
        present(alertController, animated: true, completion: nil)
    }
    
    func getPhoto(){
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
 //------------------------------------------------------- original
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        dismiss(animated: true, completion: nil)
        guard let selectedImage = info[.originalImage] as? UIImage
            else{return}
        displayImage.image = selectedImage
        picture = selectedImage.pngData()
        
        identifyFacesWithLandmarks(image: selectedImage)
        getPrediction(image: selectedImage)
        dismiss(animated: true, completion: nil)
        
    }
    
    //----------------------------------------------------------------------
    // prediction
    func getPrediction(image: UIImage){
        //let modelFile = ImageClassifier()
        let modelFile = MobileNet()
        let model = try! VNCoreMLModel(for: modelFile.model)

        let handler = VNImageRequestHandler(cgImage: image.cgImage!, options: [ : ])
        let request = VNCoreMLRequest(model: model, completionHandler: findResults)

        try! handler.perform([request])
    }

    func findResults(request: VNRequest, error: Error?) {
        guard let results = request.results as? [VNClassificationObservation] else {
            fatalError("Unable to get results")
        }

        var bestGuess = ""
        var bestConfidence: VNConfidence = 0

        for classification in results {
            if (classification.confidence > bestConfidence) {
                bestConfidence = classification.confidence
                bestGuess = classification.identifier
            }
        }
        resultguess.text = "Image is: \(bestGuess)"
        resultConfidence.text = "With confidence \(bestConfidence) out of 1"
    }
    
//--------------------------------------------------------------- Face detection
    
    func identifyFacesWithLandmarks(image: UIImage) {
        let handler = VNImageRequestHandler(cgImage: image.cgImage!, options: [ : ])
        
        messageLbl.text = "Analyzing picture..."
        
        let request = VNDetectFaceLandmarksRequest(completionHandler: handleFaceLandmarksRecognition)
        try! handler.perform([request])
    }
    
    func handleFaceLandmarksRecognition(request: VNRequest, error: Error?) {
        guard let foundFaces = request.results as? [VNFaceObservation] else {
            fatalError ("Problem loading picture to examine faces")
        }
        messageLbl.text = "Found \(foundFaces.count) faces in the picture"
        
        for faceRectangle in foundFaces {
            
            guard let landmarks = faceRectangle.landmarks else {
                continue
            }
            
            var landmarkRegions: [VNFaceLandmarkRegion2D] = []
            
            if let faceContour = landmarks.faceContour {
                landmarkRegions.append(faceContour)
            }
            if let leftEye = landmarks.leftEye {
                landmarkRegions.append(leftEye)
            }
            if let rightEye = landmarks.rightEye {
                landmarkRegions.append(rightEye)
            }
            if let nose = landmarks.nose {
                landmarkRegions.append(nose)
            }
            
            drawImage(source: displayImage.image!, boundary: faceRectangle.boundingBox, faceLandmarkRegions: landmarkRegions)
            
        }
    }
//-------------------------------------------------

    
    func drawImage(source: UIImage, boundary: CGRect, faceLandmarkRegions: [VNFaceLandmarkRegion2D])  {
        UIGraphicsBeginImageContextWithOptions(source.size, false, 1)
        let context = UIGraphicsGetCurrentContext()!
        context.translateBy(x: 0, y: source.size.height)
        context.scaleBy(x: 1.0, y: -1.0)
        context.setLineJoin(.round)
        context.setLineCap(.round)
        context.setShouldAntialias(true)
        context.setAllowsAntialiasing(true)
        
        let rect = CGRect(x: 0, y:0, width: source.size.width, height: source.size.height)
        context.draw(source.cgImage!, in: rect)
        
        //draw rectangles around faces
        var fillColor = UIColor.green
        fillColor.setStroke()
        
        let rectangleWidth = source.size.width * boundary.size.width
        let rectangleHeight = source.size.height * boundary.size.height
        
        context.addRect(CGRect(x: boundary.origin.x * source.size.width, y:boundary.origin.y * source.size.height, width: rectangleWidth, height: rectangleHeight))
        context.drawPath(using: CGPathDrawingMode.stroke)
        
        //draw facial features
        fillColor = UIColor.red
        fillColor.setStroke()
        context.setLineWidth(2.0)
        for faceLandmarkRegion in faceLandmarkRegions {
            var points: [CGPoint] = []
            for i in 0..<faceLandmarkRegion.pointCount {
                let point = faceLandmarkRegion.normalizedPoints[i]
                let p = CGPoint(x: CGFloat(point.x), y: CGFloat(point.y))
                points.append(p)
            }
            let facialPoints = points.map { CGPoint(x: boundary.origin.x * source.size.width + $0.x * rectangleWidth, y: boundary.origin.y * source.size.height + $0.y * rectangleHeight) }
            context.addLines(between: facialPoints)
            context.drawPath(using: CGPathDrawingMode.stroke)
        }
        
        let modifiedImage : UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        displayImage.image = modifiedImage
    }
    
    //------------------------------------------------------------------------------------- Segues
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
    
        if segue.destination is loadView
        {
            let vc = segue.destination as? loadView
            //        vc?.username = "Testing"
            vc?.saved = saved
        }
    }
    

}

