//
//  ViewController.swift
//  Ind02_Enriquez_Jose
//
//  Created by Jose Francisco Enriquez on 2/14/22.
//

import UIKit

class ViewController: UIViewController {

    
    // tuple to keep track of the where the hole is at. (Row,Column)
    var holeCoordinates = (r:0,c:0)
    
    //variable thats containg the hole image
    var holeImage = UIImage(named: "poweroff")
    
    //button variable connected to the shuffle button
    @IBOutlet weak var shuffleButton: UIButton!
    
    //contains image of the answer
    @IBOutlet weak var answer: UIImageView!
    
    //variables for all tiles identified by tile(row, column)
    @IBOutlet weak var hole: UIImageView!
    @IBOutlet weak var tile01: UIImageView!
    @IBOutlet weak var tile02: UIImageView!
    @IBOutlet weak var tile03: UIImageView!
    @IBOutlet weak var tile10: UIImageView!
    @IBOutlet weak var tile11: UIImageView!
    @IBOutlet weak var tile12: UIImageView!
    @IBOutlet weak var tile13: UIImageView!
    @IBOutlet weak var tile20: UIImageView!
    @IBOutlet weak var tile21: UIImageView!
    @IBOutlet weak var tile22: UIImageView!
    @IBOutlet weak var tile23: UIImageView!
    @IBOutlet weak var tile30: UIImageView!
    @IBOutlet weak var tile31: UIImageView!
    @IBOutlet weak var tile32: UIImageView!
    @IBOutlet weak var tile33: UIImageView!
    @IBOutlet weak var tile40: UIImageView!
    @IBOutlet weak var tile41: UIImageView!
    @IBOutlet weak var tile42: UIImageView!
    @IBOutlet weak var tile43: UIImageView!
    
    //2d array to keep track of where all the tiles are at
    var tiles = [[UIImageView]]()
    var answerKey = [[UIImage]]()
   
   
   /*
    loads all the imageviews in the corresponding place in the 2d array
    load all the images in a 2d array tha represents the answer key
    */
    func loadArray() -> Void{
        holeImage = hole.image
        
        tiles = [[hole, tile01, tile02, tile03],
                 [tile10, tile11, tile12, tile13],
                 [tile20, tile21, tile22, tile23],
                 [tile30, tile31, tile32, tile33],
                 [tile40, tile41, tile42, tile43],]

        answerKey = [[hole.image!, tile01.image!, tile02.image!, tile03.image!],
                     [tile10.image!, tile11.image!, tile12.image!, tile13.image!],
                     [tile20.image!, tile21.image!, tile22.image!, tile23.image!],
                     [tile30.image!, tile31.image!, tile32.image!, tile33.image!],
                     [tile40.image!, tile41.image!, tile42.image!, tile43.image!],]
    }

    
    /*
     handles the tap gestures for all the image views
     */
    @IBAction func tapHandler(_ sender: UITapGestureRecognizer) {
        
        if sender.view as? UIImageView == hole{
            //user tapped hole
            print("tapped hole")
        } else {
            //user did not tap hole
            print("Did not tap hole")
        }
        
        //index variable to store the coordinates of the tapped tile/imageView
        var tappedRow = 0
        var tappedColumn = 0
        
        //traverses through the 2d array to find the tapped imageview
        while(tappedRow <= 4){
            
            //gets the columne index of the tapped array
            tappedColumn = tiles[tappedRow].firstIndex(of: sender.view as! UIImageView) ?? -1
            
            if tappedColumn != -1 &&
               abs(holeCoordinates.r-tappedRow) <= 1 &&
               abs(holeCoordinates.c-tappedColumn) <= 1 &&
               holeCoordinates != (tappedRow, tappedColumn) {
                //we have located where the cooridnates of the tapped tile and confirmed
                //they are adjacent to the hole and are valid for swapping
                
                    if shuffleButton.titleLabel?.text == "Solved! Shuffle Again?"{
                        //user has already solved the puzzle. Reverting to unsolved state
                        shuffleButton.setTitle("Shuffle", for: .normal)
                        shuffleButton.backgroundColor = UIColor.clear
                    }
                    
                    //swap the hole with the adjacent-tapped tile
                    swap(i: tappedRow, j: tappedColumn)
                
                    //check if user has solved the puzzle
                    checkWin()
                    break
                }
            
            //increments the row index incase the the tapped imageView is in another row
            tappedRow = tappedRow + 1
        }
    }
    
    /*
     checks if the user has solved the puzzle
     */
    func checkWin() -> Void {
        
        //traverses throught the tiles and compare the images to the images in the answer key
        for i in 0...4 {
            for j in 0...3 {
                if answerKey[i][j] != tiles[i][j].image{
                    //found a mismatch. The user has not soved the puzzle
                    return
                }
            }
        }
        
        //User as solved the puzzle
        shuffleButton.setTitle("Solved! Shuffle Again?", for: .normal)
        shuffleButton.backgroundColor = UIColor.green
    }
    
    
    /*
     Shuffles the tiles in a way that is still solvable.
     Shuffles by getting random coordinates that are adjacent to the hole and
     then swaping the hole with the new coordinates
     */
    @IBAction func shuffle(_ sender: UIButton) {
        
        if sender.titleLabel?.text == "Solved! Shuffle Again?" {
            //the user has solved the puzzle and will attempt again
            sender.setTitle("Shuffle", for: .normal)
            shuffleButton.backgroundColor = UIColor.clear
        }
        
        //keeps track of how many swaps have occured
        var successfullSwap = 0
        
        //will swap until we have sufficient numbers of swaps to shuffle the tiles
        while(successfullSwap < 25){
            
            //Gets random coordinates of the tile we are attempting to swap. T
            //tilesR corresponds to the row
            //tileC corresponds to the column
            let tileR = Int.random(in: 0...4)
            let tileC = Int.random(in: 0...3)
            print("Before adjacent check the hole coordiantes are  \(holeCoordinates.r), \(holeCoordinates.c)")
            
            if(abs(holeCoordinates.r-tileR) <= 1 &&
               abs(holeCoordinates.c-tileC) <= 1 &&
               holeCoordinates != (tileR, tileC)) {
                    //the coordinates for the random tile are adjacent to the hole coordinates and therefor are valid for swapping
                
                    print("After the adjacent check the hole is currently at \(holeCoordinates.r), \(holeCoordinates.c)")
                
                    //increment amount of successful swaps
                    successfullSwap = successfullSwap + 1
                    
                    //swap the hole with the adjacent tile located at the random coordinates
                    swap(i: tileR, j: tileC)
            }
        }
    }
    
    /*
     swaps the hole with an adjacent imageView
     */
    func swap(i: Int, j: Int) -> Void{
        print("Before swap, hole is at \(holeCoordinates.r), \(holeCoordinates.c)")
        print("Hole will swap with \(i) and \(j)")
        
        //swaps the images
        let temp3 = tiles[i][j].image
        tiles[i][j].image = holeImage
        tiles[holeCoordinates.r][holeCoordinates.c].image = temp3
        
        //updates the hole reference and the hole coordinates
        hole = tiles[i][j]
        holeCoordinates = (i, j)
        
        print("After swap, hole is at \(holeCoordinates.r), \(holeCoordinates.c)")
        print()
    }
    
    
    /*
     shows or hides the answer
     */
    @IBAction func showAnswer(_ sender: UIButton) {
        
        if sender.titleLabel?.text == "Show Answer"{
            //shows the answer by bringing the imageview containing the answer to the front
            self.view.bringSubviewToFront(answer)
            answer.isHidden = false;
            sender.setTitle("Hide Answer", for: .normal)
            
        }
        if sender.titleLabel?.text == "Hide Answer" {
            //hides the answer by sending the imageview containing the answer to the back
            self.view.sendSubviewToBack(answer)
            answer.isHidden = true;
            sender.setTitle("Show Answer", for: .normal)
            
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadArray()

    }
}

