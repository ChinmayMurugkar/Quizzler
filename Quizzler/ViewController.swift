//
//  ViewController.swift
//  Quizzler
//
//  Created by Angela Yu on 25/08/2015.
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let allQuestions = QuestionBank()
    
    var pickedAnswer : Bool = false
    
    var questionNumber : Int = 0
    
    var score : Int = 0
    
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var progressBar: UIView!
    @IBOutlet weak var progressLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nextQuestion()
        
    }


    @IBAction func answerPressed(_ sender: AnyObject) {
        
        if sender.tag == 1 {
            pickedAnswer = true
        }
        if sender.tag == 2{
            pickedAnswer  = false
        }
        
        checkAnswer()
        questionNumber += 1
        
        nextQuestion()
    }
    
    
    func updateUI() {
      scoreLabel.text = "\(score)"
        progressLabel.text = "\(questionNumber+1)/\(allQuestions.list.count)"
        progressBar.frame.size.width = (view.frame.size.width/13)*CGFloat(questionNumber+1)
    }
    

    func nextQuestion() {
        
        if questionNumber < allQuestions.list.count{
            updateUI()
            questionLabel.text = allQuestions.list[questionNumber].questionText
        }
        else{
            let alert = UIAlertController(title: "Awesome", message : "you have finished", preferredStyle:.alert)
            
            let restartAction = UIAlertAction(title: "Restart", style: .default, handler: { (UIAlertAction) in
                self.startOver()
            })
            
            alert.addAction(restartAction)
            
            present(alert, animated: true, completion: nil)
            
            }
        
    }
    
    
    func checkAnswer() {
        
        let correctAnswer = allQuestions.list[questionNumber].answer
        if pickedAnswer == correctAnswer {
            print("correct !")
            ProgressHUD.showSuccess("correct !")
            score += 1
        }else{
            print("wrong !")
            ProgressHUD.showError("wrong !")
        }
        
    }
    
    
    func startOver() {
        questionNumber = 0
        score = 0
        nextQuestion()
    }
    

    
}
