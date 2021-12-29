import UIKit

enum Box: String, CaseIterable {
    case one, two, three, four, five, six, seven, eight, nine
}

class Game {
    var board = [Box: String]()
    var lastPlayer = "o"
    var playerChoices = [Box]()
    var computerChoices = [Box]()
    
    func playerMove(to box:Box) {
        //    let selectedBox = [box.rawValue: "x"]
        makeChoice(box)
        playerChoices.append(box)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: { [weak self] in
            self?.computerPlay()
        })
        
    }
    
    func makeChoice(_ box:Box) {
        guard board[box] == nil else { return }
        //    print("last Player \(lastPlayer) box \(box)")
        
        if lastPlayer == "x" {
            board[box] = "o"
            lastPlayer = "o"
            
        }
        else {
            board[box] = "x"
            lastPlayer = "x"
            
        }
        displayBoard()
        checkIfWon()
    }
    
    func computerPlay() {
        var availableBoxes = [Box]()
        //        print("in computerPlay")
        
        for eachBox in Box.allCases {
            if board[eachBox] == nil {
                availableBoxes.append(eachBox)
            }
        }
        //        print("availableBoxes \(availableBoxes)")
        
        let randIndex = Int.random(in: 0..<availableBoxes.count)
        //        print("randIndex \(randIndex) selectedbox \(availableBoxes[randIndex])")
        makeChoice(availableBoxes[randIndex])
        computerChoices.append(availableBoxes[randIndex])
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
                print("Bingo Player has won")
            }
            else if computerMatch == valid.count {
                print("Bingo Computer has won")
            }
            else if computerMatch + userMatch == 9 {
                print("Match has been drawn")
            }
            
        }
    }
    
    func displayBoard() {
        for move in board.keys {
            print("key \(move) value \(String(describing: board[move])) \n")
        }
        print("--------------------------------")
    }
}

var game = Game()
game.playerMove(to: .one)
game.playerMove(to: .two)
game.playerMove(to: .three)

//print(game.board)



