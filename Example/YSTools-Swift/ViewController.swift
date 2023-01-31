//
//  ViewController.swift
//  YSTools-Swift
//
//  Created by peanutgao on 01/31/2023.
//  Copyright (c) 2023 peanutgao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        aTextView.text = ""
        aTextView.placeholder = "aaaa"
    }

    @IBOutlet weak var aTextView: UITextView!
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        

    }

}

