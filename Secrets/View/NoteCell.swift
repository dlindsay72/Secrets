//
//  NoteCell.swift
//  Secrets
//
//  Created by Dan Lindsay on 2018-01-23.
//  Copyright © 2018 Dan Lindsay. All rights reserved.
//

import UIKit

class NoteCell: UITableViewCell {
    
    
    @IBOutlet weak var messageLbl: UILabel!
    @IBOutlet weak var lockImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    func configureCell(note: Note) {
        if note.lockStatus == .locked {
            messageLbl.text = "This note is locked. Unlock to read."
            lockImageView.isHidden = false
        } else {
            messageLbl.text = note.message
            lockImageView.isHidden = true
        }
    }
    

}
