//
//  Extensions.swift
//  ListaArtistas
//
//  Created by Leticia on 6/11/17.
//  Copyright © 2017 Leticia. All rights reserved.
//

import UIKit

extension String{
    func formatDate() -> Date{
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.timeZone = TimeZone(abbreviation: "GMT+0:00")
        let date = formatter.date(from: self)
        
        return date!
    }
    
    func loadImageFromURL() -> UIImage{
        var myImage: UIImage = UIImage(named: "noImage.jpg")!
        
        let url = URL(string: self)
        let data = try? Data(contentsOf: url!)
        myImage = UIImage(data: data!)!
        
        return myImage
    }
}

extension Date{
    func formatDate() -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMM yyyy"
        let newDate = formatter.string(from: self)
        
        return newDate
    }
}

extension UIView{
    func spinner(){
        let activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 500, height: 500))
        activityIndicator.center = self.center
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.whiteLarge
        activityIndicator.startAnimating()
        self.addSubview(activityIndicator)
    }
}


