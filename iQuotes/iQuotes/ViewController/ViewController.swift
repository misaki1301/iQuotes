//
//  ViewController.swift
//  iQuotes
//
//  Created by Alumnos on 5/5/18.
//  Copyright © 2018 Alumnos. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print("You must create an account at https://unsplash.com/developers in order to use this application")
        print("Then you'll have to add to Info.plist the key \"UnsplashApiClientId\" and your \"clientIdApiKey\" as value")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

