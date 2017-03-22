//
//  NoteTableViewController.swift
//  SchulnetzViewer
//
//  Created by Lukas Weber on 26.06.16.
//  Copyright © 2016 Lukas Weber. All rights reserved.
//

import UIKit

class NoteTableViewController: UITableViewController {

    var noten = [Note]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }



}
