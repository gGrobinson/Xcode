//
//  DrawViewController.swift
//  George_port2
//
//  Created by George Robinson on 27/03/2019.
//  Copyright © 2019 George Robinson. All rights reserved.
//

import UIKit
import Photos

class DrawViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBAction func chooseShapes(_ sender: Any) {
        switch (sender as AnyObject).tag {
        case 0: drawLines()
        case 1: drawRectangle()
        case 2: drawCircle()
        default: print("no choice")
        }
    }
    
    @IBOutlet weak var imageView: UIImageView!
    
    func drawLines() {
        
        // Define renderer
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 280, height: 250))
        
        let img = renderer.image { ctx in
            // line points
            ctx.cgContext.move(to: CGPoint(x: 20.0, y: 20.0))
            ctx.cgContext.addLine(to: CGPoint(x: 260.0, y: 230.0))
            ctx.cgContext.addLine(to: CGPoint(x: 100.0, y: 200.0))
            ctx.cgContext.addLine(to: CGPoint(x: 20.0, y: 20.0))
            
            ctx.cgContext.setLineWidth(10)
            ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
            
            // draw
            ctx.cgContext.strokePath()
        }
        
        imageView.image = img
        UIImageWriteToSavedPhotosAlbum(img, nil, nil, nil);
        
    }
    
    
    
    func drawRectangle() {
        
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 280, height: 250))
        
        let img = renderer.image { ctx in
            let rectangle = CGRect(x: 0, y: 0, width: 280, height: 250)
            
            // set properties
            ctx.cgContext.setFillColor(UIColor.yellow.cgColor)
            ctx.cgContext.setStrokeColor(UIColor.gray.cgColor)
            ctx.cgContext.setLineWidth(20)
            
            // Draw rectangle
            ctx.cgContext.addRect(rectangle)
            ctx.cgContext.drawPath(using: .fillStroke)
        }
        
        imageView.image = img
        UIImageWriteToSavedPhotosAlbum(img, nil, nil, nil);
    }
    
    func drawCircle() {
        
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 280, height: 250))
        
        let img = renderer.image { ctx in
            let rect = CGRect(x: 5, y: 5, width: 270, height: 240)
            
            // set properties
            ctx.cgContext.setFillColor(UIColor.blue.cgColor)
            ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
            ctx.cgContext.setLineWidth(10)
            
            ctx.cgContext.addEllipse(in: rect)
            ctx.cgContext.drawPath(using: .fillStroke)
        }
        
        imageView.image = img
        
        //save image
        UIImageWriteToSavedPhotosAlbum(img, nil, nil, nil);
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

}
