//
//  SchulnetzParser.swift
//  SchulnetzViewer
//
//  Created by Lukas Weber on 29.05.16.
//  Copyright © 2016 Lukas Weber. All rights reserved.
//

import Foundation

class SchulnetzParser {
    
    //html-document which has to be parsed
    var html : String?;
    
    //the url of the web-page
    var mobileUrl : String?;
    
    //the pinCode of the parser
    var pinCode : String?;
    
    
    init()
    {
        loadConfig();
    }
    
    func setConfig(mobileUrl: String, pinCode: String){
        //save Data
        UserDefaults.standard.set(mobileUrl,forKey:"MobileUrl");
        UserDefaults.standard.set(pinCode, forKey:"PinCode");
        self.loadConfig();
    }
    
    func loadConfig(){
        self.mobileUrl = UserDefaults.standard.value(forKey:"MobileUrl") as! String?;
        self.pinCode = UserDefaults.standard.value(forKey:"PinCode") as! String?;
    }
    
    func getNoten() throws -> [Note]
    {
        if(self.html != nil)
        {
            //Convert String to Bytes
            let data = self.html!.data(using: String.Encoding.unicode);
            let doc = TFHpple(htmlData: data);
            
            //create array wich would be returned later
            var noten = [Note]();
            
            //get the section with the "noten" li-elements
            let noteSection = doc?.search(withXPathQuery: "//ul[@class='pageitem']")[0] as! TFHppleElement;
            
            //Get all <li>-Columns in the <ul>
            let notenColumns = noteSection.search(withXPathQuery: "//li") as? [TFHppleElement];
            
            for noteColumn in notenColumns!
            {
                //if it's a valid column
                if (noteColumn.search(withXPathQuery: "//span[@class='header']").count > 0)
                {
                    //Get date From Span-Element
                    let date = (noteColumn.search(withXPathQuery: "//span[@class='header']")[0] as! TFHppleElement).content;
                    
                    //get the other infos out ofthe <p>-Tag and split them
                    let otherInfo = (noteColumn.search(withXPathQuery: "//p")[0] as! TFHppleElement).content
                    let otherInfoArr = otherInfo!.components(separatedBy: ";")
                    
                    //create Note object and append it
                    let note = Note(date: date!, value: otherInfoArr[2], title: otherInfoArr[1], course: otherInfoArr[0])
                    noten.append(note);
                }
            }
            
            return noten;
        }
        else{
            throw SchulnetzParserError.noContent
        }
        
    }
    
    
    func getHTML(complete: @escaping () -> Void){
        
        let headers = [
            "cache-control": "no-cache",
            "content-type": "application/x-www-form-urlencoded"
        ]
        
        let postData = NSMutableData(data: ("pin=" + (self.pinCode)!).data(using: String.Encoding.utf8)!)
        postData.append("&pc=1".data(using: String.Encoding.utf8)!)
        
        let request = NSMutableURLRequest(url: NSURL(string: self.mobileUrl!)! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        request.httpBody = postData as Data
        
        let session = URLSession.shared
        
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error)
            } else {
                //Encode the Content and set member
                let htmlContent = String(data: data!, encoding: String.Encoding.ascii)
                self.html = htmlContent
                
                ///Replace the breaks with a ";", otherwise it has problems while parsing
                self.html = self.html!.replacingOccurrences(of: "<br />", with: ";")
                
                complete()
            }
        })
        
        dataTask.resume()
    }
    
    
}
