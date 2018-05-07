//
//  QuoteOfTheDayViewController.swift
//  iQuotes
//
//  Created by Alumnos on 5/5/18.
//  Copyright © 2018 Alumnos. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class QuoteOfTheDayViewController: UIViewController {

    
    @IBOutlet weak var quoteImageView: UIImageView!
    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    var quote: Quote? {
        didSet {
            
        }
    }
    var imageUrl: String? = "" {
        didSet {
            
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        updateValues()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func updateValues() {
        if (imageUrl != "") {
            print("url", imageUrl!)
            quoteImageView.alpha = 1.0
            quoteImageView.af_setImage(withURL: URL(string: imageUrl!)!)
        }
        if let currentQuote = quote {
            
            quoteLabel.text = currentQuote.quote
            authorLabel.text = currentQuote.author
            categoryLabel.text = currentQuote.category
            dateLabel.text = currentQuote.date
            self.title = currentQuote.title
        }
    }
}
