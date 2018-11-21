//
//  StoryViewController.swift
//  BartWitting-pset2
//
//  Created by Bart Witting on 19/11/2018.
//  Copyright © 2018 Bart Witting. All rights reserved.
//

import UIKit

class StoryViewController: UIViewController {

    ///Hier wordt het verhaal ontvangen uit de vorige VC
    var theStory : Story!
    
    @IBOutlet weak var textView: UITextView!
    
    ///Deze functie maakt het scherm en vult het tekstveld in met het verhaal
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.attributedText = theStory.attributedText
        
    }
}
