//
//  NoteDetailVC.swift
//  Secrets
//
//  Created by Dan Lindsay on 2018-01-23.
//  Copyright © 2018 Dan Lindsay. All rights reserved.
//

import UIKit

class NoteDetailVC: UIViewController {

    @IBOutlet weak var textView: UITextView!
    
    var note: Note!
    var index: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        textView.text = note.message
    }

    @IBAction func lockNoteBtnWasPressed(_ sender: Any) {
        notesArray[index].lockStatus = lockStatusFlipper(note.lockStatus)
        navigationController?.popViewController(animated: true)
    }
    
}
