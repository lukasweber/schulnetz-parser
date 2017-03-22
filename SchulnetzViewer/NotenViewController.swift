//
//  FirstViewController.swift
//  SchulnetzViewer
//
//  Created by Lukas Weber on 29.05.16.
//  Copyright © 2016 Lukas Weber. All rights reserved.
//

import UIKit

class NotenViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var noten = [Note]()
    
    var refreshControl = UIRefreshControl()

    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        reloadNoten();
        
        self.refreshControl.attributedTitle = NSAttributedString(string: "Hochziehen zum Aktualisieren")
        self.refreshControl.addTarget(self, action: #selector(NotenViewController.refresh(_:)), for: UIControlEvents.valueChanged)
        self.tableView?.addSubview(refreshControl)

    }
    
    func refresh(_ sender:AnyObject) {
        reloadNoten();
    }
    
    func reloadNoten(){
        // get reference to the main app classe
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let schulnetzParser = appDelegate.schulnetzParser;
        
        // load html and parse "noten"
        schulnetzParser.getHTML(complete: { () -> () in
            
            // try to get Noten
            do{
                self.noten = try schulnetzParser.getNoten();
            }
            catch SchulnetzParserError.noContent{
                // show error message
                let alertController = UIAlertController(title: "Error", message:
                    "There is no content to parse", preferredStyle: UIAlertControllerStyle.alert)
                alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default,handler: nil))
                
                self.present(alertController, animated: true, completion: nil)
            }
            // reload tableview
            DispatchQueue.main.async(execute: { () -> Void in
                self.tableView.reloadData()
            })
            
        } as! () -> Void);
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Table view data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.noten.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! NoteTableViewCell
        
        let row = indexPath.row
        
        cell.courseLabel.text = self.noten[row].course
        cell.dateLabel.text = self.noten[row].date
        cell.noteNameLabel.text = self.noten[row].title
        cell.valueLabel.text = String(format:"%.2f", self.noten[row].value!)
        cell.valueLabel.textColor = self.noten[row].color;
        
        return cell
    }
    
}

