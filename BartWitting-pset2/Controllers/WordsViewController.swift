//
//  WordsViewController.swift
//  BartWitting-pset2
//
//  Created by Bart Witting on 19/11/2018.
//  Copyright © 2018 Bart Witting. All rights reserved.
//

import UIKit

class WordsViewController: UIViewController {

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
    
    @IBAction func unwindToStories(segue: UIStoryboardSegue) {
        updateUI()
    }
    
    enum Verhaal : String {
            case simple = "madlib0_simple", tarzan = "madlib1_tarzan", uni = "madlib2_university", clothes = "madlib3_clothes", dance = "madlib4_dance"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    var verhaal : Story = Story(withText: " ")
    
    ///This function checks which button is clicked and will activate that story
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
    @IBAction func exitBut(_ sender: Any) {
        updateUI()
        wordField.endEditing(true)
    }
    
    func updateUI() {
        storiesStack.isHidden = false
        wordsStack.isHidden = true
        exitBut.isHidden = true
        OKBut.setTitle("Next", for: .normal)
    }
    
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowStorySegue" {
            let storyviewcontroller = segue.destination as! StoryViewController
            storyviewcontroller.theStory = verhaal
        }
    }
}
