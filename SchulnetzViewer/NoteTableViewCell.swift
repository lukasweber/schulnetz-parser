//
//  NoteTableViewCell.swift
//  SchulnetzViewer
//
//  Created by Lukas Weber on 26.06.16.
//  Copyright © 2016 Lukas Weber. All rights reserved.
//

import UIKit

class NoteTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    @IBOutlet var courseLabel: UILabel!
    @IBOutlet var noteNameLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var valueLabel: UILabel!
}
