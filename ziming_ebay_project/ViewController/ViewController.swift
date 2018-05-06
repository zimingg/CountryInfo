//
//  ViewController.swift
//  ziming_ebay_project
//
//  Created by zimingg on 3/2/18.
//  Copyright © 2018 zimingg. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    //initial views and create a list to store data
    private var myTableView:UITableView!
    private var mySearchBar:UISearchBar!
    private var myNavigationBar:UINavigationBar!
    var COUNTRYLIST = [Country]()

    //set up the screen when view is loaded
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        setNavigationBar()
        setTableView()
        getData()
        setSearchBar()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //try to reload data if failed getting data
    override func viewDidAppear(_ animated: Bool) {
        //print(COUNTRYLIST.count)
        if COUNTRYLIST.count == 0{
            getData()
            self.myTableView.reloadData()
            //print("loded")
        }
        
        //print("loded")
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
    func setView(){
        self.view.backgroundColor = UIColor(red:0.15, green:0.15, blue:0.15, alpha:1.0)
        
    }
    
    //for tableview
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //set value for the detail view and present the detail view
        let subview = DetailViewController()
        
        subview.countryInfo = COUNTRYLIST[indexPath.row]
        subview.countryName = "try"
        present(subview, animated: true, completion: nil)
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return COUNTRYLIST.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath as IndexPath) as! CustomTableViewCell
        let picCode = COUNTRYLIST[indexPath.row].alpha2Code
        let picname:String = picCode?.lowercased() ?? ""
        
        cell.pictureImageView.image = UIImage(named: "png100px/\(picname).png")//get country flag from a folder
        cell.titleLabel.text = "\(COUNTRYLIST[indexPath.row].name ?? "" )"

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    
    
    func setTableView(){
        let barHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height
        
        myTableView = UITableView(frame: CGRect(x: 0, y: barHeight, width: displayWidth, height: displayHeight - barHeight))
        //myTableView = UITableView(frame: self.view.bounds)
        myTableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "MyCell")
        myTableView.dataSource = self
        myTableView.delegate = self
        //myTableView.backgroundColor = UIColor.lightGray
        self.view.addSubview(myTableView)
        myTableView.setAnchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 54, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
    }
    
    //for search bar
    func setSearchBar(){
        
        mySearchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 50))
        mySearchBar.delegate = self
        mySearchBar.tintColor = UIColor.lightGray
        self.myTableView.tableHeaderView = mySearchBar
        
    }
    
    func searchBar(_ searchBar:UISearchBar, textDidChange searchText: String){
        
        if (searchText == ""){
            getData()
        }
        else{
            COUNTRYLIST = COUNTRYLIST.filter({(country) -> Bool in
                return (country.name?.lowercased().contains(searchText.lowercased()))!
            })
        }
        self.myTableView.reloadData()
    }
    
   //for navigationbar
    func setNavigationBar() {
        let screenSize: CGRect = UIScreen.main.bounds
        myNavigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: 50))
        let navItem = UINavigationItem(title: "Countries");
        

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
    
    //get data from a api and store them
    func getData(){
        
        let url = URL(string: "https://restcountries-v1.p.mashape.com/all")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("1IosQYQKu0mshuIZjcqiIXbiLGJSp1dBB9Yjsnfd2aISWLA7Yk", forHTTPHeaderField: "X-Mashape-Key")
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
           
            if error != nil {
                //print("error=\(error!)")
                print("error")
                self.COUNTRYLIST = []
                return
            }
            else{
                do{
                    let countryList = try JSONDecoder().decode([Country].self, from: data!)
                    //print(countryList[0])
                    self.COUNTRYLIST = countryList
                    
                    //asynchronous reload tableview with data
                    DispatchQueue.main.async {
                        self.myTableView.reloadData()
                    }
                }
                catch let jsonerr{
                    print("Error Serialization JSON: \(jsonerr)")
                }
            }
        }
        task.resume()
    }
}

