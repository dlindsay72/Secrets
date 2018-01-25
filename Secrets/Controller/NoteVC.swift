//
//  NoteVC.swift
//  Secrets
//
//  Created by Dan Lindsay on 2018-01-23.
//  Copyright © 2018 Dan Lindsay. All rights reserved.
//

import UIKit
import LocalAuthentication

class NoteVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
}

extension NoteVC: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "noteCell", for: indexPath) as? NoteCell else { return UITableViewCell() }
        let note = notesArray[indexPath.row]
        cell.configureCell(note: note)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //pass note and present viewcontroller
        if notesArray[indexPath.row].lockStatus == .locked {
            authenticateBiometrics(completion: { (authenticated) in
                if authenticated {
                    let lockStatus = notesArray[indexPath.row].lockStatus
                    notesArray[indexPath.row].lockStatus = lockStatusFlipper(lockStatus)
                    DispatchQueue.main.async {
                        self.pushNoteFor(indexPath: indexPath)
                    }
                }
            })
        } else {
            pushNoteFor(indexPath: indexPath)
        }
    }
    
    func pushNoteFor(indexPath: IndexPath) {
        guard let noteDetailVC = storyboard?.instantiateViewController(withIdentifier: "NoteDetailVC") as? NoteDetailVC else { return }
        noteDetailVC.note = notesArray[indexPath.row]
        noteDetailVC.index = indexPath.row
        navigationController?.pushViewController(noteDetailVC, animated: true)
    }
    
    func authenticateBiometrics(completion: @escaping (Bool) -> Void) {
        let myContext = LAContext()
        let myLocalizedReasonString = "Our app uses TouchID/FaceID to secure your notes."
        var authError: NSError?
        
        if #available(iOS 8.0, macOS 10.12.1, *) {
            if myContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &authError) {
                myContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: myLocalizedReasonString, reply: { (success, evaluateError) in
                    if success {
                        completion(true)
                    } else {
                        guard let evaluateErrorString = evaluateError?.localizedDescription else { return }
                        // present alert
                        self.showAlert(withMessage: evaluateErrorString)
                        completion(false)
                    }
                })
            } else {
                guard let authErrorString = authError?.localizedDescription else { return }
                showAlert(withMessage: authErrorString)
                completion(false)
            }
        } else {
            completion(false)
        }
    }
    
    func showAlert(withMessage message: String) {
        let alertVC = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertVC.addAction(action)
        present(alertVC, animated: true, completion: nil)
    }
}

















