//
//  Note.swift
//  SchulnetzViewer
//
//  Created by Lukas Weber on 29.05.16.
//  Copyright © 2016 Lukas Weber. All rights reserved.
//

import Foundation
import UIKit;

class Note {
    
    //-----------Members--------------
    
    //Das Datum an dem Die Püfung war
    let date : String?;
    
    //Der Wert der Note
    let value : Double?;
    
    //Die Bezeichnung der Prüfung
    let title : String?;
    
    //Die Bezeichung des Kurses in dem die Note gemacht wurde
    let course : String?;
    
    //Die Farbe der Note
    let color : UIColor;
    
    //-----------Class-Attr-------------
    
    
    
    init(date : String, value : String, title : String, course : String)
    {
        self.value = Double(value)
        self.title = title
        self.course = course
        self.date = date
        
        if(self.value! < 4.0){
            self.color = UIColor(hue: 0.0083, saturation: 1, brightness: 0.66, alpha: 1.0)
        }
        else if(self.value! >= 5.0)
        {
            self.color = UIColor(hue: 0.3472, saturation: 1, brightness: 0.6, alpha: 1.0)
        }
        else{
            self.color = UIColor(hue: 0, saturation: 0, brightness: 0.34, alpha: 1.0)
        }
        
    }
    
    
}
