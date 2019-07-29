//
//  MapViewController.swift
//  e-life
//
//  Created by PalameMon on 7/19/19.
//  Copyright © 2019 PalameMon. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit
import Alamofire
import SwiftyJSON

class MyAnnotation : NSObject,MKAnnotation {
    let title: String?
    let discipline: String
    let discount: String
    let address: String
    let imageUrl: String
    let coordinate: CLLocationCoordinate2D
    
    init(title: String, discipline: String, coordinate: CLLocationCoordinate2D, discount: String, address: String, imageUrl: String) {
        self.title = title
        self.discipline = discipline
        self.coordinate = coordinate
        self.discount = discount
        self.address = address
        self.imageUrl = imageUrl
        
        super.init()
    }
    
    var subtitle: String? {
        return title
    }
    
    var markerTintColor: UIColor  {
        switch discipline {
        case "1":
            return .red
        case "2":
            return .cyan
        case "3":
            return .blue
        case "4":
            return .purple
        default:
            return .green
        }
    }
}

class ArtworkMarkerView: MKMarkerAnnotationView {
    override var annotation: MKAnnotation? {
        willSet {
            // 1
            guard let artwork = newValue as? MyAnnotation else { return }
            // 2
            canShowCallout = true
            calloutOffset = CGPoint(x: -5, y: 5)
            rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            markerTintColor = artwork.markerTintColor
            glyphText = String(artwork.discipline.first!)
        }
    }
}

class MapScreen: UIViewController {

    
    @IBOutlet var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    let regionInMeters: Double = 10000
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    //Mark:- Need to Change this
    let storeURL = "http://elifedemo.vipgz1.idcfengye.com/Store/findall"
    
    var storeArray : [JSON] = []
    
    var storeAnnotation = [MyAnnotation]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.register(ArtworkMarkerView.self,
                         forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        // Do any additional setup after loading the view.
        checkLocationService()
    }
    
    func addAnnotation() {
        print(storeArray.count)
        storeArray.forEach { (store) in
            let annotation = MyAnnotation(title: store["storename"].stringValue, discipline: store["type"].stringValue, coordinate: CLLocationCoordinate2D(latitude: store["latitude"].doubleValue, longitude: store["longitude"].doubleValue), discount: store["discount"].stringValue, address: store["address"].stringValue, imageUrl: store["img"].stringValue)
            storeAnnotation.append(annotation)
        }
        mapView.addAnnotations(storeAnnotation)
    }
    
    func centerUserLocation() {
        if let location = locationManager.location?.coordinate {
            let region = MKCoordinateRegion.init(center: location, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
            mapView.setRegion(region, animated: true)
        }
    }
    
    func checkLocationService (){
        if CLLocationManager.locationServicesEnabled() {
            //Setup location manager
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            
            //check Authorization
            checkLocationAuthorization()
        } else {
            //Show alert... go here to turn them on
            appDelegate.showAlert(viewcontroller: self, message: "Please turn on location permission to use this feature.")
        }
    }
    
    func checkLocationAuthorization() {
        switch CLLocationManager.authorizationStatus() {
            case .authorizedWhenInUse:
                //do map stuff
                mapView.showsUserLocation = true
                centerUserLocation()
                fetchData()
                //addAnnotation()
                locationManager.startUpdatingLocation()
                break
            case .denied:
                //alert user
                appDelegate.showAlert(viewcontroller: self, message: "无法定位")
                break
            case .notDetermined:
                locationManager.requestWhenInUseAuthorization()
                break
            case .restricted:
                //appDelegate.showAlert(viewscontroler: self, message: "无法定位")
                //alert user
                break
            case .authorizedAlways:
                break
        @unknown default:
            fatalError("Error")
        }
    }
    
    func fetchData() {
        AF.request(storeURL, method: .get, parameters: ["community" : appDelegate.community]).responseJSON { (response) in
            if response.response?.statusCode == 200 {
                if let json = response.value {
                    let data = JSON(json).arrayValue
                    self.storeArray = data
                    print (data)
                    self.addAnnotation()
                }
            } else {
                self.appDelegate.showAlert(viewcontroller: self, message: "Error! Please try again!")
            }
        }
    }
    
}

extension MapScreen : CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard  let location = locations.last else { return }
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion.init(center: center, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
        mapView.setRegion(region, animated: true)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        //we'll be back
        checkLocationAuthorization()
    }
}

extension MapScreen : MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        let annView = view.annotation as! MyAnnotation
        let mapDetail = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "mapDetail") as! MapDetailViewController
        print (annView.imageUrl)
        mapDetail.storeName = annView.title!
        mapDetail.discount = annView.discount
        mapDetail.address = annView.address
        mapDetail.imageUrl = annView.imageUrl
        
        self.navigationController?.pushViewController(mapDetail, animated: true)
        
    }
}
