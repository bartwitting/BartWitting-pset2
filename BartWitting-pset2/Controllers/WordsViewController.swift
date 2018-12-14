//
//  WordsViewController.swift
//  BartWitting-pset2
//
//  Created by Bart Witting on 19/11/2018.
//  Copyright © 2018 Bart Witting. All rights reserved.
//

import UIKit

class WordsViewController: UIViewController {

    /// Defining all outlets
    @IBOutlet weak var storiesStack: UIStackView!
    @IBOutlet weak var simpleBut: UIButton!
    @IBOutlet weak var tarzanBut: UIButton!
    @IBOutlet weak var uniBut: UIButton!
    @IBOutlet weak var clothesBut: UIButton!
    @IBOutlet weak var danceBut: UIButton!
    
    @IBOutlet weak var wordsStack: UIStackView!
    @IBOutlet weak var wordCountLabel: UILabel!
    @IBOutlet weak var wordField: UITextField!
    @IBOutlet weak var OKBut: UIButton!
    
    @IBOutlet weak var exitBut: UIButton!
    
    /// Action to go back to this opening screen and activate a function
    @IBAction func unwindToStories(segue: UIStoryboardSegue) {
        updateUI()
    }
    
    /// An enumeration for the file names
    enum Verhaal : String {
            case simple = "madlib0_simple", tarzan = "madlib1_tarzan", uni = "madlib2_university", clothes = "madlib3_clothes", dance = "madlib4_dance"
    }
    
    /// Building the screen and activate a function
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    /// An empty story to fill in and send to the next VC
    var verhaal : Story = Story(withText: " ")
    
    /// Action to see which story to pick and update the link
    @IBAction func storyButPress(_ sender: UIButton) {
        var link = ""
        switch sender {
        case simpleBut:
            link.append(Verhaal.simple.rawValue)
        case tarzanBut:
            link.append(Verhaal.tarzan.rawValue)
        case uniBut:
            link.append(Verhaal.uni.rawValue)
        case clothesBut:
            link.append(Verhaal.clothes.rawValue)
        case danceBut:
            link.append(Verhaal.dance.rawValue)
        default:
            break
        }
        pickStory(file: link)
    }
    
    /// Action to get the text and send it to the next funciton
    @IBAction func fillInButPress(_ sender: Any) {
        let woord = wordField.text!
        if woord.count > 0 {
            fillInWord(word:woord)
        }
        else {
            let alert = UIAlertController(title: "Empty text", message: "You forgot to fill in a word", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
        
    }
    
    /// Action to go back to the menu for picking stories
    @IBAction func exitBut(_ sender: Any) {
        updateUI()
        wordField.endEditing(true)
    }
    
    /// Function to build the screen correctly at the begining
    func updateUI() {
        storiesStack.isHidden = false
        wordsStack.isHidden = true
        exitBut.isHidden = true
        OKBut.setTitle("Next", for: .normal)
    }
    
    /// Function to retrieve the story from the file and update the labels
    func pickStory(file: String) {
        storiesStack.isHidden = true
        wordsStack.isHidden = false
        exitBut.isHidden = false
        let storyPath = Bundle.main.path(forResource: file, ofType: "txt")
        let theText = try! String(contentsOfFile: storyPath!, encoding: .utf8)
        verhaal = Story(withText: theText)
        wordCountLabel.text = "\(verhaal.remainingPlaceholders)/\(verhaal.totalPlaceholders)"
        wordField.placeholder = verhaal.nextPlaceholder?.lowercased()
    }

    /// Function to fill in the words in the story
    func fillInWord(word:String) {
        verhaal.fillInPlaceholder(word: word)
        if verhaal.remainingPlaceholders == 1 {
            OKBut.setTitle("GO!", for: .normal)
        }
        else if verhaal.remainingPlaceholders == 0 && verhaal.isFilledIn {
            performSegue(withIdentifier: "ShowStorySegue", sender: nil)
        }
        wordCountLabel.text = "\(verhaal.remainingPlaceholders)/\(verhaal.totalPlaceholders)"
        wordField.placeholder = verhaal.nextPlaceholder?.lowercased()
        wordField.text = ""
    }
    
    /// Action to send the completed story to the next VC
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowStorySegue" {
            let storyviewcontroller = segue.destination as! StoryViewController
            storyviewcontroller.theStory = verhaal
        }
    }
}
