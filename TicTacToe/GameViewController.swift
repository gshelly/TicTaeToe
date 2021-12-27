//
//  GameViewController.swift
//  TicTacToe
//
//  Created by Shelly Gupta on 12/21/21.
//  Copyright © 2021 Macco. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {

    @IBOutlet weak var playerNameLabel: UILabel!
    @IBOutlet weak var playerScoreLabel: UILabel!
    @IBOutlet weak var computerScoreLabel: UILabel!
    
    @IBOutlet weak var boardStackView: UIStackView!
    @IBOutlet weak var box1: UIImageView!
    @IBOutlet weak var box2: UIImageView!
    @IBOutlet weak var box3: UIImageView!
    @IBOutlet weak var box4: UIImageView!
    @IBOutlet weak var box5: UIImageView!
    @IBOutlet weak var box6: UIImageView!
    @IBOutlet weak var box7: UIImageView!
    @IBOutlet weak var box8: UIImageView!
    @IBOutlet weak var box9: UIImageView!
    @IBOutlet weak var firstRowWonLineView: UIView!
    
    var playerName: String!
    var lastValue = "o"
    var playerChoices = [Box]()
    var computerChoices = [Box]()
    var isUserMatch = false
    var isComputerMatch = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        playerNameLabel.text = playerName + ":"
        
        createTap(on: box1, type: .one)
        createTap(on: box2, type: .two)
        createTap(on: box3, type: .three)
        createTap(on: box4, type: .four)
        createTap(on: box5, type: .five)
        createTap(on: box6, type: .six)
        createTap(on: box7, type: .seven)
        createTap(on: box8, type: .eight)
        createTap(on: box9, type: .nine)
    }
    
    func createTap(on imageView: UIImageView, type box: Box) {
        let tap = UITapGestureRecognizer(target: self, action: #selector(boxClicked(_:)))
        tap.name = box.rawValue
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tap)
    }
    
    @objc func boxClicked(_ sender: UITapGestureRecognizer) {
       let selected = getBox(from: sender.name ?? "")
       
//        selected.image = UIImage(named: "ex")
        makeChoice(selected)
        if let boxName = sender.name, let boxEnumObj = Box(rawValue: boxName) {
            playerChoices.append(boxEnumObj)
        }
        checkIfWon()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: { [weak self] in
            self?.computerPlay()
        })
    }
    
    func computerPlay() {
        var availableSpaces = [UIImageView]()
        var availableBox = [Box]()
        
        for name in Box.allCases {
            let box = getBox(from: name.rawValue)
            if box.image == nil {
                availableSpaces.append(box)
                availableBox.append(name)
            }
        }
        guard availableSpaces.count > 0 && availableSpaces.count != 9  && !isUserMatch && !isComputerMatch else { return }
        
        let randIndex = Int.random(in: 0..<availableSpaces.count)
        makeChoice(availableSpaces[randIndex])
        computerChoices.append(availableBox[randIndex])
        checkIfWon()
    }
    
    func makeChoice(_ selectedImage: UIImageView) {
        guard selectedImage.image == nil else { return }
        
        if lastValue == "x" {
            selectedImage.image = UIImage(named: "oh")
            lastValue = "o"
        } else {
            selectedImage.image = UIImage(named: "ex")
            lastValue = "x"
        }
    }
    
    func checkIfWon() {
        var correctPattern = [[Box]]()
        
        let firstRow: [Box] = [.one, .two, .three]
        let secondRow: [Box] = [.four, .five, .six]
        let thirdRow: [Box] = [.seven, .eight, .nine]
        
        let firstCol: [Box] = [.one, .four, .seven]
        let secondCol: [Box] = [.two, .five, .eight]
        let thirdCol: [Box] = [.three, .six, .nine]
        
        let backwardSlash: [Box] = [.one, .five, .nine]
        let forwardSlash: [Box] = [.three, .five, .seven]
        
        correctPattern.append(firstRow)
        correctPattern.append(secondRow)
        correctPattern.append(thirdRow)
        correctPattern.append(firstCol)
        correctPattern.append(secondCol)
        correctPattern.append(thirdCol)
        correctPattern.append(backwardSlash)
        correctPattern.append(forwardSlash)
        
        for valid in correctPattern {
            let userMatch = playerChoices.filter({ valid.contains($0) }).count
            let computerMatch = computerChoices.filter({ valid.contains($0) }).count
            
            if userMatch == valid.count {
                print("\(String(describing: playerNameLabel.text)) has won playerChoices \(playerChoices) with pattern \(valid)")
                playerScoreLabel.text = String((Int(playerScoreLabel.text ?? "0") ?? 0) + 1)
                
//                resetGame()
                firstRowWonLineView.isHidden = false
//                self.view.bringSubviewToFront(firstRowWonLineView)
                isUserMatch = true
                break
            }
            else if computerMatch == valid.count  {
                print("Computer has won has won comChoices \(computerChoices) with pattern \(valid)")
                computerScoreLabel.text = String((Int(computerScoreLabel.text ?? "0") ?? 0) + 1)
//                resetGame()
                isComputerMatch = true
                break
            }
        }
        
        if computerChoices.count + playerChoices.count == 9 && !isUserMatch && !isComputerMatch{
            print("Game is draw")
//            resetGame()
        }
    }
    func resetGame() {
        for name in Box.allCases {
            let box = getBox(from: name.rawValue)
            box.image = nil
        }
        lastValue = "o"
        playerChoices = []
        computerChoices = []
        isUserMatch = false
        isComputerMatch = false
        firstRowWonLineView.isHidden = true
    }
    
    @IBAction func playButtonActionCalled(_ sender: Any) {
        resetGame()
    }
    func getBox(from name: String) -> UIImageView {
        let box = Box(rawValue: name)
        
        switch box {
        case .one:
            return box1
        case .two:
            return box2
        case .three:
            return box3
        case .four:
            return box4
        case .five:
            return box5
        case .six:
            return box6
        case .seven:
            return box7
        case .eight:
            return box8
        case .nine:
            return box9
        case .none:
            return UIImageView()
        }
    }
    
    @IBAction func closeButtonClicked(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
enum Box: String, CaseIterable {
    case one, two, three, four, five, six, seven, eight, nine
}
