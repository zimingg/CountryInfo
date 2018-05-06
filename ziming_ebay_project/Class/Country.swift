//
//  Country.swift
//  ziming_ebay_project
//
//  Created by zimingg on 3/2/18.
//  Copyright © 2018 zimingg. All rights reserved.
//

import Foundation

//struct Country 
struct Country:Decodable{
    let name:String?
    let topLevelDomain:[String]?
    let alpha2Code:String?
    let alpha3Code:String?
    let callingCodes:[String]?
    let capital:String?
    let altSpellings:[String]?
    let region:String?
    let subregion:String?
    let population:Int?
    let latlng:[Float]?
    let demonym:String?
    let area:Float?
    let gini:Float?
    let timezones:[String]?
    let borders:[String]?
    let nativeName:String?
    let numericCode:String?
    let currencies:[String]?
    let languages:[String]?
    let translations:Dictionary<String, String?>?
    let relevance:String?
    
}



