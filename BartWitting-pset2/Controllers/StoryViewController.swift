//
//  StoryViewController.swift
//  BartWitting-pset2
//
//  Created by Bart Witting on 19/11/2018.
//  Copyright © 2018 Bart Witting. All rights reserved.
//

import UIKit

class StoryViewController: UIViewController {

    var theStory : Story!
    
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.attributedText = theStory.attributedText
        
    }
}
