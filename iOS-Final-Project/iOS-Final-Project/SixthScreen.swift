//
//  SixthScreen.swift
//  iOS-Final-Project
//
//  Created by Vishwajeet Pandey on 18/05/22.
//

import UIKit
import CoreLocation
import MapKit

class SixthScreen: UIViewController,CLLocationManagerDelegate {

    var address : String!
    
     
    @IBOutlet weak var l1: UILabel!
    @IBOutlet weak var l2: UILabel!
    @IBOutlet weak var l3: UILabel!
    
    
    @IBOutlet weak var l4: UILabel!
    
    @IBOutlet weak var l5: UILabel!
    @IBOutlet weak var l6: UILabel!
    
    
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        locationManager.requestAlwaysAuthorization()
    }
    @IBAction func button1Click() {
        
        if CLLocationManager.locationServicesEnabled(){
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.distanceFilter = kCLDistanceFilterNone
            locationManager.startUpdatingLocation()
        }
        else
        {
            print("services are not enabled")
        }
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
       
       let lat: Double = manager.location!.coordinate.latitude
       let long: Double = manager.location!.coordinate.longitude
                    
       print("\(lat) and \(long)")
             
             l1.text = "latitude: \(lat)"
             l2.text = "longitude: \(long)"
        
        
        if let loc = CLLocation(latitude: lat, longitude: long) as? CLLocation {
            CLGeocoder().reverseGeocodeLocation(loc, completionHandler: {(placemarks,error) in
                if let placemark1 = placemarks?[0]{
                    let name = placemark1.name!
                    let country = placemark1.country!
                    let administrative = placemark1.administrativeArea!
                    let locality = placemark1.locality!
                    let postalCode = placemark1.postalCode!
                    self.address = locality + "," + country
                    //print("\(name),\(administrative),\(country),\(locality),\(postalCode)")
                    self.l3.text = "\(name),\(administrative),\(country),\(locality),\(postalCode)"
        
        
   }
            })
        }
    }
   
   func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
       
       
       print("\(error)")
   
       
   }
    
    @IBAction func button2Click() {
        let session1 = URLSession.shared

         //let weatherURL = URL(string: "http://api.openweathermap.org/data/2.5/weather?q=Bengaluru,IN?&APPID=f31356634fbc4c64c86edd02aaf817c2")!
        
        let weatherURL = URL(string: "http://api.openweathermap.org/data/2.5/weather?q=\(self.address!)?&APPID=f31356634fbc4c64c86edd02aaf817c2")!
        let task1 = session1.dataTask(with: weatherURL){
            (data: Data?, response: URLResponse?, error: Error?) in
            if let error1 = error
            {
                  print("Error:\n\(error1)")
            }
            else{
                if let data1 = data{
                 //   print("Bytes Data:\n\(data1)")
                   
                   // coverting bytes to String
                   
                    let dataString = String(data: data1, encoding: String.Encoding.utf8)
                    
  // print("All the weather data:\n\(dataString!)")
                    if let firstDictionary = try? JSONSerialization.jsonObject(with: data1, options: .allowFragments) as? NSDictionary{
                     //   print("first Dictionary values: \(firstDictionary)")
                           
                        if let secondDictionary = firstDictionary.value(forKey: "main") as? NSDictionary{
                            
                          //  print("main Dictionary values are: \(secondDictionary)")
                         
                         
                        // to display temperature
                         
                            if let temperaturevalue = secondDictionary.value(forKey: "temp") {
                                DispatchQueue.main.async {
                                      //print("\(self.tf1.text!): \(temperaturevalue)°F")
                                    let temperatureInC : Double = (temperaturevalue as! Double - 273.15).rounded(.toNearestOrEven)
                                    self.l4.text = "Temperature : \(temperatureInC)°C"
                                                                      }
                            }
                            if let humidityvalue = secondDictionary.value(forKey: "humidity") {
                                                                               DispatchQueue.main.async {
                                                                                    // print("\(self.tf1.text!): \(humidityvalue)")
                                                                                  self.l5.text = "Humidity : \(humidityvalue)"
                                                                                                                     }
                                                                                                            }
                            if let feelsLikevalue = secondDictionary.value(forKey: "feels_like") {
                                        DispatchQueue.main.async {
                                            
                            //print("\(self.tf1.text!): \(feelsLikevalue)")
                                            let feelsLikeInC : Double = (feelsLikevalue as! Double - 273.15).rounded(.toNearestOrEven)
                                self.l6.text = "Feels Like : \(feelsLikeInC)°C"
                                                                                                }
                                                                                }
                            
                        }
                        else
                        {
                             print("Error: unable to find temperature in dictionary")
                        }
                    }
                    else {
                                print("Error: unable to convert json data")
                               }
                }
                else {
                      print("Error: did not receive data")
                     }
            }
        }
        task1.resume()

    }
            
}
