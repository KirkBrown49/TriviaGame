//
//  AddViewQuestionController.swift
//  TriviaBoi
//
//  Created by Kirk Brown on 10/19/18.
//  Copyright © 2018 Kirk Brown. All rights reserved.
//

import UIKit

class AddViewQuestionController: UIViewController {
    @IBOutlet weak var newQuestion: UITextField!
    @IBOutlet weak var AddAnswerA: UITextField!
    @IBOutlet weak var AddAnswerB: UITextField!
    @IBOutlet weak var AddAnswerC: UITextField!
    @IBOutlet weak var AddAnswerD: UITextField!
    @IBOutlet weak var CorrectAnswer: UISegmentedControl!
    
    var newTrivia: TriviaQuestion?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: Selector("endEditing:")))
    }
    

    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    
    
    @IBAction func cancelButtonTaped(_ sender: Any) {
        self.performSegue(withIdentifier: "unwindSegueToQuizScreen", sender: self)
    }
    // this will allow the user to add the info in the add question screen and allow them to pick the correct answer
    @IBAction func addTapped(_ sender: Any) {
        guard
            let question = newQuestion.text, !question.isEmpty,
            let a = AddAnswerA.text, !a.isEmpty,
            let b = AddAnswerB.text, !b.isEmpty,
            let c = AddAnswerC.text, !c.isEmpty,
            let d = AddAnswerC.text, !d.isEmpty
            else {
                let errorAlert = UIAlertController(title: "Error", message: "Please fill all fields, or press cancel to return to quiz.", preferredStyle: UIAlertController.Style.alert)
                let dismissAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default) {UIAlertAction in}
                errorAlert.addAction(dismissAction)
                self.present(errorAlert,animated: true, completion: nil)
                return
        }
        
        newTrivia = TriviaQuestion(question: question, answers: [a,b,c,d], correctAnswerIndex: CorrectAnswer.selectedSegmentIndex)
        performSegue(withIdentifier: "unwindSegueToQuizScreen", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard
            let destinationVC = segue.destination as? QuizViewController,
            let newTriviaQuestion = newTrivia
            else {return}
        destinationVC.questions.append(newTriviaQuestion)
        destinationVC.resetGame()
    }
}

