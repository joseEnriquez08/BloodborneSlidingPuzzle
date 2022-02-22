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
    var answerKey = [[UIImageView]]()
    
   
   /*
    loads all the imageviews in the corresponding place in the 2d array
    */
    func loadArray() -> Void{
        tiles = [[hole, tile01, tile02, tile03],
                 [tile10, tile11, tile12, tile13],
                 [tile20, tile21, tile22, tile23],
                 [tile30, tile31, tile32, tile33],
                 [tile40, tile41, tile42, tile43],]
        answerKey = [[hole, tile01, tile02, tile03],
                 [tile10, tile11, tile12, tile13],
                 [tile20, tile21, tile22, tile23],
                 [tile30, tile31, tile32, tile33],
                 [tile40, tile41, tile42, tile43],]
    }

    
    @IBAction func tapHandler(_ sender: UITapGestureRecognizer) {
        if sender.view as? UIImageView == hole{
            print("tapped hole")
        } else {
            print("Did not tap hole")
        }
    }
    
    
    
    /*
     Shuffles the tiles in a way that is still solvable.
     Shuffles by getting random coordinates that are adjacent to the hole and
     then swaping the hole with the new coordinates
     */
    @IBAction func shuffle(_ sender: UIButton) {
        
        //keeps track of how many swaps have occured
        var successfullSwap = 0
        
        //will swap until we have sufficient numbers of swaps to shuffle the tiles
        while(successfullSwap < 3){
            
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
    
    func swap(i: Int, j: Int) -> Void{
        print("Before swap, hole is at \(holeCoordinates.r), \(holeCoordinates.c)")
        print("Hole will swap with \(i) and \(j)")
        
        // other ways ive tried to swap
//        hole.frame = tiles[i][j].frame
//        tiles[i][j].frame = hole.frame

//        (hole.frame, tiles[i][j].frame) = (tiles[i][j].frame, hole.frame)
        
//        var tFrame = tiles[i][j].frame
//        tiles[i][j].frame = hole.frame
//        hole.frame = tFrame
        
        //swaps the actual images
//        let temp = tiles[i][j].image
//        tiles[i][j].image = tiles[holeCoordinates.r][holeCoordinates.c].image
//        //hole.image = temp
//        tiles[holeCoordinates.r][holeCoordinates.c].image = temp
        
        //swaps the UIIMAGE in the 2d array
        let temp2 = tiles[i][j]
        tiles[i][j] = tiles[holeCoordinates.r][holeCoordinates.c]
        hole = temp2
        tiles[holeCoordinates.r][holeCoordinates.c] = temp2
        
        
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

