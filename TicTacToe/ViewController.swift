//
//  ViewController.swift
//  TicTacToe
//
//  Created by Emmanuel Okwara on 24/05/2020.
//  Copyright © 2020 Macco. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var startBtn: UIButton!
    @IBOutlet weak var cardView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }

    func setupUI() {
        startBtn.layer.cornerRadius = 10
        cardView.layer.cornerRadius = 10
        cardView.layer.shadowOpacity = 0.4
        cardView.layer.shadowColor = UIColor.black.cgColor
        cardView.layer.shadowRadius = 10
        cardView.layer.shadowOffset = .zero
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        nameField.resignFirstResponder()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? GameViewController {
            vc.playerName = nameField.text
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "goToGameVc" {
            if nameField.text!.trimmingCharacters(in: .whitespaces).isEmpty {
                return false
            }
        }
        return true
    }
}

