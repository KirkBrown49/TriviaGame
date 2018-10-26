//
//  ViewController.swift
//  TriviaBoi
//
//  Created by Kirk Brown on 10/19/18.
//  Copyright © 2018 Kirk Brown. All rights reserved.
//

import UIKit

class QuizViewController: UIViewController {
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerAButton: UIButton!
    
    @IBOutlet weak var answerBButton: UIButton!
    
    @IBOutlet weak var answerCButton: UIButton!
    @IBOutlet weak var answerDButton: UIButton!
    var questions = [TriviaQuestion]()
    var questionsPlaceholder = [TriviaQuestion]()
    
    var currentIndex: Int!
    
    var score = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    
    var currentQuestion: TriviaQuestion! {
        didSet {
            if let currentQuestion = currentQuestion {
                questionLabel.text = currentQuestion.question
                answerAButton.setTitle(currentQuestion.answers[0], for: .normal)
                answerBButton.setTitle(currentQuestion.answers[1], for: .normal)
                answerCButton.setTitle(currentQuestion.answers[2], for: .normal)
                answerDButton.setTitle(currentQuestion.answers[3], for: .normal)
                setNewColors()
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        populateQuestions()
        getNewQuestion()
        
        
    }
    
    func populateQuestions(){
        let question1 = TriviaQuestion(question: "How it do?", answers: ["it do ","it dont","good","bad"], correctAnswerIndex: 0)
        
        let question2 = TriviaQuestion(question: "How is the weather?", answers: ["Good","Bad","Perfect","Chance of Death",] , correctAnswerIndex: 2 )
        let question3 = TriviaQuestion(question: "What is the best game", answers: ["FortNite","Call of Duty","PUBG","None of the others"], correctAnswerIndex: 3)
        let question4 = TriviaQuestion(question: "Who is the Creator of Captain America ", answers: ["Stan Lee","Jack Kirby","Malcolm Wheeler-Nicholson","Martin Goodman"], correctAnswerIndex: 1)
        questions = [question1, question2, question3, question4]
    }
    
    func getNewQuestion(){
        if questions.count > 0 {
            currentIndex = Int.random(in: 0..<questions.count)
            currentQuestion = questions[currentIndex]
        }else{
            // we need to make a function for a game over scenario
           showGameOverAlert()
    }
}
func showGameOverAlert(){
let endAlert = UIAlertController(title: "Trivia Results", message: "Game Over! Your score was \(score) out of \(questionsPlaceholder.count)", preferredStyle: UIAlertController.Style.alert)
    let resetAction = UIAlertAction(title: "Reset", style: UIAlertAction.Style.default) {UIAlertAction
        in
      self.resetGame()
    }
    endAlert.addAction(resetAction)
    self.present(endAlert,animated: true, completion: nil)
}

let backgroundColors = [
    UIColor(red: 255/255, green: 80/255, blue: 80/255, alpha: 1.0),
    UIColor(red: 17/255, green: 137/255, blue: 127/255, alpha: 1.0),
    UIColor(red: 137/255, green: 17/255, blue: 115/255, alpha: 1.0),
    UIColor(red: 38/255, green: 75/255, blue: 202/255, alpha: 1.0),
    UIColor(red: 220/255, green: 18/255, blue: 73/255, alpha: 1.0)
]

func setNewColors(){
    let randomNumber = Int.random(in: 1...100)
    let randomColorA = backgroundColors[randomNumber % 4]
    let randomColorB = backgroundColors[(randomNumber + 1) % 4]
    let randomColorC = backgroundColors[(randomNumber + 2) % 4]
    let randomColorD = backgroundColors[(randomNumber + 3) % 4]
    
    answerAButton.backgroundColor = randomColorA
    answerBButton.backgroundColor = randomColorB
    answerCButton.backgroundColor = randomColorC
    answerDButton.backgroundColor = randomColorD
    
}
@IBAction func answeredTapped(_ sender:UIButton){
    if currentQuestion.correctAnswerIndex == sender.tag{
        score += 1
        showCorrectAnswerAlert()
        //Need to fill out showCorrectAnswerAlert
    }else{
        showIncorrectAnswerAlert()
    }
}
func showIncorrectAnswerAlert(){
    let incorrectAlert = UIAlertController(title: "Incorrect", message: "\(currentQuestion.correctAnswer) is the answer we were lokking for! Bad!", preferredStyle: .actionSheet)
    let okayAction = UIAlertAction(title: "...Sorry", style: UIAlertAction.Style.default) { UIAlertAction in
        self.questionsPlaceholder.append(self.questions[self.currentIndex])
        self.questions.remove(at: self.currentIndex)
        self.getNewQuestion()
    }
    incorrectAlert.addAction(okayAction)
    self.present(incorrectAlert, animated: true, completion: nil)
}

func showCorrectAnswerAlert(){
    let correctAlert = UIAlertController(title: "Correct", message: "\(currentQuestion.correctAnswer) is the correct answer! Good Work!", preferredStyle: .actionSheet)
    let okayAction = UIAlertAction(title: "Thank You", style: UIAlertAction.Style.default) { UIAlertAction in
        self.questionsPlaceholder.append(self.questions[self.currentIndex])
        self.questions.remove(at: self.currentIndex)
        self.getNewQuestion()
    }
    correctAlert.addAction(okayAction)
    self.present(correctAlert, animated: true, completion: nil)
}

func resetGame() {
    //need to reset game after adding new question
    score = 0
    if !questions.isEmpty {
        questionsPlaceholder.append(contentsOf: questions)
        questions.removeAll()
    }
    questions = questionsPlaceholder
    questionsPlaceholder.removeAll()
    getNewQuestion()
    
}
    @IBAction func resetTapped(_ sender: Any) {
        resetGame()
    }
    
@IBAction func unwindToQuizScreen(segue: UIStoryboardSegue){}

}
