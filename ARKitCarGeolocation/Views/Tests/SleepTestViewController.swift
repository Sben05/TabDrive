//
//  TestViewController.swift
//  Hackathon
//
//  Created by Shreeniket Bendre on 8/15/20.
//  Copyright © 2020 Shreeniket Bendre. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {

    
    //MARK:- Variables
    var cq = 0
    let mnum = Int.random(in: 30...87)
    var mnumString = ""
    var points = 0
    var toGo = true
    
    
    //MARK:- IBOutlets
    @IBOutlet weak var displayLabel: UILabel!
    @IBOutlet weak var mainButton: UIButton!
    @IBOutlet weak var qb1: UIButton!
    @IBOutlet weak var qb2: UIButton!
    @IBOutlet weak var qb3: UIButton!
    @IBOutlet weak var qb4: UIButton!
    @IBOutlet weak var textfield: UITextField!
    
    
    //MARK:- IBActions
    @IBAction func editedTextView(_ sender: Any) {
        
        
    }
    
    @IBAction func tappedMain(_ sender: Any) {
        toGo = true
        if(mainButton.backgroundColor == UIColor.red){
            points+=1
        }
        else if(mainButton.backgroundColor == UIColor.yellow){
            points-=1
        }
        cq+=1
        start()
    }
    @IBAction func tappedQ1(_ sender: Any) {
        toGo = true
        points+=2
        start()
    }
    @IBAction func tappedQ2(_ sender: Any) {
        toGo = true
        points+=1
        start()
    }
    @IBAction func tappedQ3(_ sender: Any) {
        toGo = true
        points-=1
        start()
    }
    @IBAction func tappedQ4(_ sender: Any) {
        toGo = true
        points-=2
        start()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        reset()
        mnumString = "\(mnum)"
        
        
        displayLabel.numberOfLines = 0
        
        textfield.clearsOnInsertion = true
        self.textfield.addDoneButton(title: "Done", target: self, selector: #selector(tapDone(sender:)))
        start()
        
    }
    func reset(){

        displayLabel.text = ""
        mainButton.isHidden = true

        qb1.isHidden = true
        qb2.isHidden = true
        qb3.isHidden = true
        qb4.isHidden = true

        qb1.isHidden = true
        qb2.isHidden = true
        qb3.isHidden = true
        qb4.isHidden = true

        textfield.isHidden = true

    }
    func start(){
        
        if (toGo == true && cq == 0){
            questionOne()
        }
       
        if cq == 1 {
            questionThree()
        }
        if toGo && cq == 2{
            questionThree()
        }
        if toGo && cq == 3{
            questionFour()
        }
        if toGo && cq == 4{
            questionFive()
        }
        if toGo && cq == 5{
            questionSix()
        }
        if toGo && cq == 7{
            questionEight()
        }

        
    }
    func questionOne(){
//        displayLabel.text = "Remember this number: "
//
//        displayLabel.isHidden = false
//        mainButton.isHidden = false
//        toGo = false
//        cq = 1
        displayLabel.text = "Remember this number: "
        mainButton.setTitle(mnumString, for: .normal)
        mainButton.isHidden = false
        toGo = false
        
        
        
    }

    func questionThree(){
        mainButton.isHidden = true
        displayLabel.text = "What is your age range?"
        qb1.isHidden = false
        qb2.isHidden = false
        qb3.isHidden = false
        qb4.isHidden = false
        
        qb1.setTitle("18-30", for: .normal)
        qb2.setTitle("31-55", for: .normal)
        qb3.setTitle("56-70", for: .normal)
        qb4.setTitle("71 or more", for: .normal)
        toGo = false
        cq = 3
    }
    func questionFour(){
        
        displayLabel.text = "How many hours did you sleep in the last 2 Days?"
        qb1.setTitle("24 or more", for: .normal)
        qb2.setTitle("16-24", for: .normal)
        qb3.setTitle("9-15", for: .normal)
        qb4.setTitle("0-8", for: .normal)
        toGo = false
        cq = 4
    }
    func questionFive(){
        
        displayLabel.text = "Which best describes you right now"
        qb1.isHidden = false
        qb2.isHidden = false
        qb3.isHidden = false
        qb4.isHidden = false
        
        qb1.setTitle("Could not be more Energetic", for: .normal)
        qb2.setTitle("Normal", for: .normal)
        qb3.setTitle("Tired", for: .normal)
        qb4.setTitle("Exhausted", for: .normal)
        toGo = false
        cq = 5
 
    }
    func questionSix(){
    
        displayLabel.text = "What have you done today?"
        qb1.isHidden = false
        qb2.isHidden = false
        qb3.isHidden = false
        qb4.isHidden = false
        
        qb1.setTitle("Just Woke Up / Relaxing", for: .normal)
        qb2.setTitle("Work / School", for: .normal)
        qb3.setTitle("Physical Activty for More than 1 hour", for: .normal)
        qb4.setTitle("Partying or Driving all Day", for: .normal)
        toGo = false
        cq = 7
        
    }
//
    func questionEight(){
        qb1.isHidden = true
        qb2.isHidden = true
        qb3.isHidden = true
        qb4.isHidden = true
        
        displayLabel.text = "Last question, what was the number I asked you to memorize?"
        textfield.isHidden = false
        toGo = false
        cq = 8
    }
    
    
    func endGame(){
        if(points>4){
            let alert = UIAlertController(title: "Good Job!", message: "You have passed the drowsiness quiz. It is safe for you to drive.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                self.performSegue(withIdentifier: "home", sender: self)
            }))
            present(alert, animated: true)
        }
        if(points>2 && points<=4){
            let alert = UIAlertController(title: "Think Before Driving", message: "You have passed the drowsiness quiz, however, based on your score, driving may be dangerous.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                self.performSegue(withIdentifier: "home", sender: self)
            }))
            present(alert, animated: true)
        }
        if(points<3){
            let alert = UIAlertController(title: "Warning", message: "You have failed the test. It is not safe for you to drive at this time. This is for both your safety, and others.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                self.performSegue(withIdentifier: "home", sender: self)
            }))
            present(alert, animated: true)
        }
        
    }
    
    
    @objc func tapDone(sender: Any) {
        self.view.endEditing(true)
        let num = textfield.text
        print(num)
        if (num == mnumString){
            print("yeet")
            points += 2
        }
        textfield.resignFirstResponder()
        toGo = true
        endGame()
    }
    

}
//extension UITextField {
//    
//    func addDoneButton(title: String, target: Any, selector: Selector) {
//        
//        let toolBar = UIToolbar(frame: CGRect(x: 0.0,
//                                              y: 0.0,
//                                              width: UIScreen.main.bounds.size.width,
//                                              height: 44.0))//1
//        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)//2
//        let barButton = UIBarButtonItem(title: title, style: .plain, target: target, action: selector)//3
//        toolBar.setItems([flexible, barButton], animated: false)//4
//        self.inputAccessoryView = toolBar//5
//    }
//}
