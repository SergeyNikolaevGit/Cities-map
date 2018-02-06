//
//  ViewController.swift
//  Cities map
//
//  Created by Sergey Nikolaev on 2/6/18.
//  Copyright © 2018 Sergey Nikolaev. All rights reserved.
//
//Permission is hereby granted, free of charge, to any person obtaining a copy
//of this software and associated documentation files (the "Software"), to deal
//in the Software without restriction, including without limitation the rights
//to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//copies of the Software, and to permit persons to whom the Software is furnished
//to do so, subject to the following conditions:
//
//The above copyright notice and this permission notice shall be included in all
//copies or substantial portions of the Software.
//
//THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//THE SOFTWARE.

import UIKit
import MapKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, MKMapViewDelegate {
    
    @IBOutlet var appNameLabel: UILabel!
    @IBOutlet var citiesMap: MKMapView!
    @IBOutlet var citiesPicker: UIPickerView!
    @IBOutlet var coordinateLabel: UILabel!
    
    var cityArray = NSArray()
    var latitudeArray = NSArray()
    var longitudeArray = NSArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        appNameLabel.text? = "Welcome to cities"
        coordinateLabel.text? = ""
        
        citiesMap.layer.cornerRadius = 8
        
        let citiesPlistPath = Bundle.main.path(forResource: "Сities", ofType: "plist")
        let latitudePlistPath = Bundle.main.path(forResource: "Lat", ofType: "plist")
        let longitudePlistPath = Bundle.main.path(forResource: "Lon", ofType: "plist")
        
        cityArray = NSArray(contentsOfFile: citiesPlistPath!)!
        latitudeArray = NSArray(contentsOfFile: latitudePlistPath!)!
        longitudeArray = NSArray(contentsOfFile: longitudePlistPath!)!
        
        citiesPicker.delegate = self
        citiesPicker.dataSource = self
        
        citiesMap.delegate = self
        
    }
    
    func showCityOnMap(cityLat:Double, cityLong:Double, cityName:String) {
        
        let cityCoordinate2D = CLLocationCoordinate2D(latitude: cityLat, longitude: cityLong)
        let cityCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let cityCoordinateRigion = MKCoordinateRegion(center: cityCoordinate2D, span: cityCoordinateSpan)
        
        citiesMap.setRegion(cityCoordinateRigion, animated: true)
        
        let cityAnatation = MKPointAnnotation()
        cityAnatation.title = cityName
        cityAnatation.coordinate = CLLocationCoordinate2D(latitude: cityLat, longitude: cityLong)
        
        citiesMap.addAnnotation(cityAnatation)
        
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return cityArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return (cityArray[row] as! String)
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        coordinateLabel.text? = "\(cityArray[row]) - (\(latitudeArray[row]) - \(longitudeArray[row]))"
        
        let lat = (latitudeArray[row] as! NSString).doubleValue
        let long = (longitudeArray[row] as! NSString).doubleValue
        
        showCityOnMap(cityLat: lat, cityLong: long, cityName: cityArray[row] as! String)
        
    }
    
}

