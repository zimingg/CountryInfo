//
//  CustomTableViewCell.swift
//  ziming_ebay_project
//
//  Created by zimingg on 3/2/18.
//  Copyright © 2018 zimingg. All rights reserved.
//


import Foundation
import UIKit

//define the cell in table view
class CustomTableViewCell: UITableViewCell {
    
    //for cell view
    let cellView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.94, green: 0.94, blue: 0.94, alpha: 1.0)
        view.setCellShadow()
        
        return view
    }()
    
    //for country flag image
    let pictureImageView: UIImageView = {
        let iv = UIImageView()
        
        
        iv.contentMode = .scaleAspectFit
        
        return iv
    }()
    
    //for country name
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Name"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = UIColor.darkGray
        return label
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        cellView.layer.masksToBounds = true
        cellView.layer.cornerRadius = 15
        pictureImageView.layer.masksToBounds = true
        pictureImageView.layer.cornerRadius = 15
        setup()
    }
    
    func setup() {
        backgroundColor =  UIColor.white
        //UIColor(r: 245, g: 245, b: 245)
        
        addSubview(cellView)
        cellView.addSubview(pictureImageView)
        cellView.addSubview(titleLabel)
        
        cellView.setAnchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 4, paddingLeft: 8, paddingBottom: 4, paddingRight: 8)
        
        pictureImageView.setAnchor(top: nil, left: cellView.leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 40, height: 40)
        pictureImageView.centerYAnchor.constraint(equalTo: cellView.centerYAnchor).isActive = true
        
        titleLabel.setAnchor(top: nil, left: pictureImageView.rightAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 20, paddingBottom: 0, paddingRight: 20, height: 40)
        titleLabel.centerYAnchor.constraint(equalTo: pictureImageView.centerYAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
