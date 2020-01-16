//
//  GpsViewController.swift
//  George_port2
//
//  Created by George Robinson on 27/03/2019.
//  Copyright © 2019 George Robinson. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class GpsViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    let locationManager = CLLocationManager()
    let initialLocation = CLLocation(latitude: 53.483959, longitude: -2.244644)
    let searchRadius: CLLocationDistance = 2000
    
    @IBAction func location(_ sender: Any) {
        // 1
        let status = CLLocationManager.authorizationStatus()
        switch status {
        // 1
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            return
            
        // 2
        case .denied, .restricted:
            let alert = UIAlertController(title: "Location Services disabled", message: "Please enable Location Services in Settings", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okAction)
            
            present(alert, animated: true, completion: nil)
            return
        case .authorizedAlways, .authorizedWhenInUse:
            searchInMap()
            break
            

            
        }
        
        // 4
        locationManager.delegate = self
    locationManager.startUpdatingLocation()
    }
    
    @IBOutlet weak var longitudeLbl: UILabel!
    
    @IBOutlet weak var LatitudeLbl: UILabel!
    
    @IBOutlet weak var mapView: MKMapView!
    
    
    // 1 Print location if available
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let currentLocation = locations.last {
            LatitudeLbl.text = "\(currentLocation.coordinate.latitude)"
            longitudeLbl.text = "\(currentLocation.coordinate.longitude)"
        }
    }
    
    // 2 Print Error
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        mapView.delegate = self
        
        let coordinateRegion = MKCoordinateRegion.init(center: initialLocation.coordinate, latitudinalMeters: searchRadius * 2.0, longitudinalMeters: searchRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
        
        searchInMap()
    }
    
    func searchInMap() {
        // This is to define the search in natural language
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = "University"
        // Coordinate span
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        request.region = MKCoordinateRegion(center: initialLocation.coordinate, span: span)
        // Search according to the criteria
        let search = MKLocalSearch(request: request)
        search.start(completionHandler: {(response, error) in
            
            for item in response!.mapItems {
                self.addPinToMapView(title: item.name, latitude: item.placemark.location!.coordinate.latitude, longitude: item.placemark.location!.coordinate.longitude)
            }
        })
    }
        
        func addPinToMapView(title: String?, latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
            if let title = title {
                let location = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
                let annotation = MKPointAnnotation()
                
                annotation.coordinate = location
                annotation.title = title
                
                mapView.addAnnotation(annotation)
            }
        }


}
