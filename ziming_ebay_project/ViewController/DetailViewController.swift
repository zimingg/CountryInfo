//
//  DetailViewController.swift
//  ziming_ebay_project
//
//  Created by zimingg on 3/2/18.
//  Copyright © 2018 zimingg. All rights reserved.
//


import Foundation
import UIKit
import MapKit

class DetailViewController: UIViewController,UIScrollViewDelegate{
    
    //initial views and class variables
    private var myScrollView: UIScrollView!
    private var myContainerView:UIView!
    private var myNavigationBar:UINavigationBar!
    private var myMapView:MKMapView!

    var countryInfo: Country? = nil
    var countryName:String = String()
    
    
    //set up the screen when the view is loaded
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setView()
        setNavigationBar()
        setScrollView()
        setMapView()
        showPertinentData()
        
    }
    func setView(){
        self.view.backgroundColor = UIColor(red:0.15, green:0.15, blue:0.15, alpha:1.0)
    }

    //create the scrollview
    func setScrollView(){
        myScrollView = UIScrollView()
        
        myScrollView.delegate = self
        myScrollView.contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height*1.2)
        
        myContainerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        myScrollView.addSubview(myContainerView)
        
        self.view.addSubview(myScrollView)
        myScrollView.setAnchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 54, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        
    }
    
    //create the map view
    func setMapView(){
        myMapView = MKMapView()
        var location = CLLocationCoordinate2D(latitude: 0,longitude: 0)
        
        let lat:[Float] = (countryInfo?.latlng ?? [])!
        if lat.count == 2{
            //print(lat)
            location = CLLocationCoordinate2D(latitude: CLLocationDegrees(lat[0]), longitude: CLLocationDegrees(lat[1]))
        }
        
        myMapView.addAnnotation(MapPin(coordinate: location, title: countryInfo?.name ?? "", subtitle: ""))
        let region = MKCoordinateRegionMakeWithDistance(location, 800000, 800000)//chose an appropreate range
        myMapView.setRegion(region, animated: true)
        myMapView.isScrollEnabled = false
        myMapView.isZoomEnabled = false
        
        myContainerView.addSubview(myMapView)
        myMapView.translatesAutoresizingMaskIntoConstraints = false
        myMapView.topAnchor.constraint(equalTo: myContainerView.topAnchor).isActive = true
        myMapView.centerXAnchor.constraint(equalTo:myContainerView.centerXAnchor).isActive = true
        myMapView.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        myMapView.heightAnchor.constraint(equalToConstant: view.frame.width*0.618).isActive = true

    }
    
    func setNavigationBar() {
        let screenSize: CGRect = UIScreen.main.bounds
        myNavigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: 80))
        let navItem = UINavigationItem(title: "\(countryInfo?.name ?? "")")
        let doneItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: nil, action: #selector(done))
        navItem.rightBarButtonItem = doneItem
        navItem.rightBarButtonItem?.setBackButtonBackgroundVerticalPositionAdjustment(CGFloat(20), for: UIBarMetrics.default)
        myNavigationBar.setItems([navItem], animated: true)
        myNavigationBar.backgroundColor = .white
        myNavigationBar.barTintColor = .black
        myNavigationBar.titleTextAttributes =
            [
                NSAttributedStringKey.foregroundColor : UIColor.white,
                //NSFontAttributeName : UIFont(name: "Helvetica Neue", size: 20)!
        ]
        self.view.addSubview(myNavigationBar)
        myNavigationBar.setAnchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
    }
    
    //function for right navigation bar button
    @objc func done() { 
        //print("done pressed")
        self.dismiss(animated: true, completion: nil)
    }

    override func viewWillAppear(_ animated: Bool) {
        
        //change the statusBarStyle to fit the background color of navigation bar
        UIApplication.shared.statusBarStyle = .lightContent
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //change the statusBarStyle back when leave the view
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.default
    }
    
    //show labels on the view
    func showPertinentData(){
        
        //captial
        let Captial = UILabel(frame: CGRect(x: 0, y: 0, width: myContainerView.frame.width, height: 21))
        Captial.textAlignment = .center
        Captial.text = "Capital of the country is:"
        Captial.font = UIFont.boldSystemFont(ofSize: myContainerView.frame.width*0.04)
        //Captial.backgroundColor = UIColor.lightGray
        myContainerView.addSubview(Captial)
        Captial.translatesAutoresizingMaskIntoConstraints = false
        Captial.topAnchor.constraint(equalTo: myMapView.bottomAnchor,constant: myContainerView.frame.width*0.07).isActive = true
        Captial.centerXAnchor.constraint(equalTo: myContainerView.centerXAnchor).isActive = true
        
        let theCaptial = UILabel(frame: CGRect(x: 0, y: 0, width: myContainerView.frame.width, height: myContainerView.frame.width*0.1))
        theCaptial.textAlignment = .center
        theCaptial.text = "\(countryInfo?.capital ?? "Unknown")"
        theCaptial.font = UIFont.systemFont(ofSize: myContainerView.frame.width*0.035)
        theCaptial.textColor = UIColor.lightGray
        myContainerView.addSubview(theCaptial)
        theCaptial.translatesAutoresizingMaskIntoConstraints = false
        theCaptial.topAnchor.constraint(equalTo: Captial.bottomAnchor,constant: myContainerView.frame.width*0.07).isActive = true
        theCaptial.centerXAnchor.constraint(equalTo: myContainerView.centerXAnchor).isActive = true
        
        //region
        let Region = UILabel(frame: CGRect(x: 0, y: 0, width: myContainerView.frame.width, height: 21))
        Region.textAlignment = .center
        Region.text = "The country is in region:"
        Region.font = UIFont.boldSystemFont(ofSize: myContainerView.frame.width*0.04)
        myContainerView.addSubview(Region)
        Region.translatesAutoresizingMaskIntoConstraints = false
        Region.topAnchor.constraint(equalTo: theCaptial.bottomAnchor,constant: myContainerView.frame.width*0.07).isActive = true
        Region.centerXAnchor.constraint(equalTo: myContainerView.centerXAnchor).isActive = true
        
        let theRegion = UILabel(frame: CGRect(x: 0, y: 0, width: myContainerView.frame.width, height: 21))
        theRegion.textAlignment = .center
        theRegion.text = "\(countryInfo?.region ?? "Unknown")"
        theRegion.font = UIFont.systemFont(ofSize: myContainerView.frame.width*0.035)
        theRegion.textColor = UIColor.lightGray
        myContainerView.addSubview(theRegion)
        theRegion.translatesAutoresizingMaskIntoConstraints = false
        theRegion.topAnchor.constraint(equalTo: Region.bottomAnchor,constant: myContainerView.frame.width*0.07).isActive = true
        theRegion.centerXAnchor.constraint(equalTo: myContainerView.centerXAnchor).isActive = true
        
        //population
        let Population = UILabel(frame: CGRect(x: 0, y: 0, width: myContainerView.frame.width, height: 21))
        Population.textAlignment = .center
        Population.text = "The population of this country is:"
        Population.font = UIFont.boldSystemFont(ofSize: myContainerView.frame.width*0.04)
        myContainerView.addSubview(Population)
        Population.translatesAutoresizingMaskIntoConstraints = false
        Population.topAnchor.constraint(equalTo: theRegion.bottomAnchor,constant: myContainerView.frame.width*0.07).isActive = true
        Population.centerXAnchor.constraint(equalTo: myContainerView.centerXAnchor).isActive = true
        
        let thePopulation = UILabel(frame: CGRect(x: 0, y: 0, width: myContainerView.frame.width, height: 21))
        thePopulation.textAlignment = .center
        thePopulation.text = "\(countryInfo?.population ?? 0)"
        thePopulation.font = UIFont.systemFont(ofSize: myContainerView.frame.width*0.035)
        thePopulation.textColor = UIColor.lightGray
        myContainerView.addSubview(thePopulation)
        thePopulation.translatesAutoresizingMaskIntoConstraints = false
        thePopulation.topAnchor.constraint(equalTo: Population.bottomAnchor,constant: myContainerView.frame.width*0.07).isActive = true
        thePopulation.centerXAnchor.constraint(equalTo: myContainerView.centerXAnchor).isActive = true
        
        //area
        let Area = UILabel(frame: CGRect(x: 0, y: 0, width: myContainerView.frame.width, height: 21))
        Area.textAlignment = .center
        Area.text = "The area of this country is:"
        Area.font = UIFont.boldSystemFont(ofSize: myContainerView.frame.width*0.04)
        myContainerView.addSubview(Area)
        Area.translatesAutoresizingMaskIntoConstraints = false
        Area.topAnchor.constraint(equalTo: thePopulation.bottomAnchor,constant: myContainerView.frame.width*0.07).isActive = true
        Area.centerXAnchor.constraint(equalTo: myContainerView.centerXAnchor).isActive = true
        
        let theArea = UILabel(frame: CGRect(x: 0, y: 0, width: myContainerView.frame.width, height: 21))
        theArea.textAlignment = .center
        theArea.text = "\(countryInfo?.area ?? 0)"
        theArea.font = UIFont.systemFont(ofSize: myContainerView.frame.width*0.035)
        theArea.textColor = UIColor.lightGray
        myContainerView.addSubview(theArea)
        theArea.translatesAutoresizingMaskIntoConstraints = false
        theArea.topAnchor.constraint(equalTo: Area.bottomAnchor,constant: myContainerView.frame.width*0.07).isActive = true
        theArea.centerXAnchor.constraint(equalTo: myContainerView.centerXAnchor).isActive = true
        
        //native name
        let NativeName = UILabel(frame: CGRect(x: 0, y: 0, width: myContainerView.frame.width, height: 21))
        NativeName.textAlignment = .center
        NativeName.text = "The NativeName of this country is:"
        NativeName.font = UIFont.boldSystemFont(ofSize: myContainerView.frame.width*0.04)
        myContainerView.addSubview(NativeName)
        NativeName.translatesAutoresizingMaskIntoConstraints = false
        NativeName.topAnchor.constraint(equalTo: theArea.bottomAnchor,constant: myContainerView.frame.width*0.07).isActive = true
        NativeName.centerXAnchor.constraint(equalTo: myContainerView.centerXAnchor).isActive = true
        
        let theNativeName = UILabel(frame: CGRect(x: 0, y: 0, width: myContainerView.frame.width, height: 21))
        theNativeName.textAlignment = .center
        theNativeName.text = "\(countryInfo?.nativeName ?? "Unknown")"
        theNativeName.font = UIFont.systemFont(ofSize: myContainerView.frame.width*0.035)
        theNativeName.textColor = UIColor.lightGray
        myContainerView.addSubview(theNativeName)
        theNativeName.translatesAutoresizingMaskIntoConstraints = false
        theNativeName.topAnchor.constraint(equalTo: NativeName.bottomAnchor,constant: myContainerView.frame.width*0.07).isActive = true
        theNativeName.centerXAnchor.constraint(equalTo: myContainerView.centerXAnchor).isActive = true
        
        //code
        let Code = UILabel(frame: CGRect(x: 0, y: 0, width: myContainerView.frame.width, height: 21))
        Code.textAlignment = .center
        Code.text = "alpha2Code of this country is:"
        Code.font = UIFont.boldSystemFont(ofSize: myContainerView.frame.width*0.04)
        myContainerView.addSubview(Code)
        Code.translatesAutoresizingMaskIntoConstraints = false
        Code.topAnchor.constraint(equalTo: theNativeName.bottomAnchor,constant: myContainerView.frame.width*0.07).isActive = true
        Code.centerXAnchor.constraint(equalTo: myContainerView.centerXAnchor).isActive = true
        
        let theCode = UILabel(frame: CGRect(x: 0, y: 0, width: myContainerView.frame.width, height: 21))
        theCode.textAlignment = .center
        theCode.text = "\(countryInfo?.alpha2Code ?? "Unknown")"
        theCode.font = UIFont.systemFont(ofSize: myContainerView.frame.width*0.035)
        theCode.textColor = UIColor.lightGray
        myContainerView.addSubview(theCode)
        theCode.translatesAutoresizingMaskIntoConstraints = false
        theCode.topAnchor.constraint(equalTo: Code.bottomAnchor,constant: myContainerView.frame.width*0.07).isActive = true
        theCode.centerXAnchor.constraint(equalTo: myContainerView.centerXAnchor).isActive = true

    }
}
