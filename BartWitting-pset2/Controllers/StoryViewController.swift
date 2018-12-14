//
//  StoryViewController.swift
//  BartWitting-pset2
//
//  Created by Bart Witting on 19/11/2018.
//  Copyright © 2018 Bart Witting. All rights reserved.
//

import UIKit

class StoryViewController: UIViewController {

    /// Defining the variables, this time the story from the last VC
    var theStory : Story!
    
    /// Defining the outlets
    @IBOutlet weak var textView: UITextView!
    
    /// Building the screen by filling in the created story
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.attributedText = theStory.attributedText
    }
}
