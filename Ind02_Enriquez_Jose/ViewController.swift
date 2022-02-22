//
//  ViewController.swift
//  Ind02_Enriquez_Jose
//
//  Created by Jose Francisco Enriquez on 2/14/22.
//

import UIKit

class ViewController: UIViewController {

    
    
    var holeCoordinates = (r:0,c:0)
    //variables for all tiles identified by (row, column)
    
    @IBOutlet weak var answer: UIImageView!
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
    
    var tiles = [[UIImageView]]()
    var answerKey = [[UIImageView]]()
    
   
   
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

    
    
    @IBAction func shuffle(_ sender: UIButton) {
        var successfullSwap = 0
        while(successfullSwap < 25){
            let i = Int.random(in: 0...4)
            let j = Int.random(in: 0...3)
            
            if(abs(holeCoordinates.r-i) <= 1 &&
               abs(holeCoordinates.c-j) <= 1){
                successfullSwap = successfullSwap + 1
                swap(i: i, j: j)
            }
        }
    }
    
    func swap(i: Int, j: Int) -> Void{
        
        //swaps the actual images
        let temp = tiles[i][j].image
        tiles[i][j].image = hole.image
        tiles[holeCoordinates.r][holeCoordinates.c].image = temp
        
        //swaps the UIIMAGE in the 2d array
        let temp2 = tiles[i][j]
        tiles[i][j] = hole
        tiles[holeCoordinates.r][holeCoordinates.c] = temp2
        holeCoordinates = (i, j)
    }
    
    
       
    @IBAction func showAnswer(_ sender: UIButton) {
        
        if sender.titleLabel?.text == "Show Answer"{
            
            self.view.bringSubviewToFront(answer)
            answer.isHidden = false;
            sender.setTitle("Hide Answer", for: .normal)
            
        }
        if sender.titleLabel?.text == "Hide Answer" {
            self.view.sendSubviewToBack(answer)
            answer.isHidden = true;
            sender.setTitle("Show Answer", for: .normal)
            
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadArray()
        //self.view.bringSubviewToFront(answer)
        
        //swap(i: 1, j: 1)
        
        // Do any additional setup after loading the view.
       
        
    }


}

