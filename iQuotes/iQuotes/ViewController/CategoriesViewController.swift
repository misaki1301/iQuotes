//
//  CategoriesViewController.swift
//  iQuotes
//
//  Created by Alumnos on 5/5/18.
//  Copyright © 2018 Alumnos. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

private let reuseIdentifier = "Cell"

class CategoriesViewController: UITableViewController {
    var currentIndex = 0
    var categories: [Category] = [] {
        didSet {
            self.tableView?.reloadData()
        }
    }
    var quotes: [Quote] = [] {
        didSet {
            self.tableView?.reloadData()
        }
    }
    var imageURL: String = ""
    
    var categoryStore = CategoryStore()
    var quoteStore = QuoteStore()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
//        self.quoteStore.deleteAllQuotes()
        updateCategories()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        currentIndex = indexPath.row
        self.performSegue(withIdentifier: "showQuote", sender: self)
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "showQuote" {
            let destination = segue.destination as! QuoteOfTheDayViewController
            print("CategoryName: ", categories[currentIndex].name)
            updateQuotes()
            getQuoteByCategoryName(categoryName: categories[currentIndex].name)
            getImageRelativeToQuoteCategory(withQuery: categories[currentIndex].name)
            if let i = quotes.index(where: { $0.category == categories[currentIndex].name }) {
                destination.quote = quotes[i]
                destination.imageUrl = imageURL
            }
            
        }
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return categories.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! CategoryCell
        
        // Configure the cell...
        let category = categories[indexPath.row]
        cell.updateValue(from: category)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Categories"
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */
    
    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    
    func updateCategories() {
        Alamofire.request(TheySaidSoApiService.categories_json_format).responseJSON(completionHandler: { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                if (json["error"] != JSON.null) {
                    let message = json["error"]["message"]
                    print("Status Error with Message: \(message)")
                    let categories_data = self.categoryStore.findAll(forEntityName: "CategoryEntity") as! [CategoryEntity]
                    for data in categories_data {
                        self.categories.append(Category.init(name: data.name!))
                    }
                } else {
                    var categories_temp: [Category] = []
                    categories_temp = Category.from(dCategory: json["contents"]["categories"].dictionaryObject as! Dictionary<String, String>)
                    self.categories = categories_temp
                    self.categoryStore.deleteAllCategories()
                    for i in 0...categories_temp.count - 1 {
                        self.categoryStore.addCategory(name: categories_temp[i].name)
                    }
                }
            case .failure (let error):
                print("\(error)")
                return
            }
        })
        
    }
    
    func updateQuotes() {
        let quote_data = self.quoteStore.findAll(forEntityName: "QuoteEntity") as! [QuoteEntity]
        print("Should be 8 at the end:", quote_data.count)
        for data in quote_data {
            self.quotes.append(Quote.init(quote: data.quote!, author: data.author!, length: data.length!, category: data.category!, title: data.title!, date: data.date!, id: data.id!))
        }
    }
    
    func getQuoteByCategoryName(categoryName: String) {
        let parameters = ["category": categoryName]
        Alamofire.request(TheySaidSoApiService.qod_json_format, parameters: parameters).responseJSON(completionHandler: { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                if (json["error"] != JSON.null) {
                    let message = json["error"]["message"]
                    print("Status Error with Message: \(message)")
                    let quote_data = self.quoteStore.findAll(forEntityName: "QuoteEntity", withCategoryName: categoryName) as! [QuoteEntity]
                    print("should be 8 at the end:", quote_data.count)
                    for data in quote_data {
                        self.quotes.append(Quote.init(quote: data.quote!, author: data.author!, length: data.length!, category: data.category!, title: data.title!, date: data.date!, id: data.id!))
                    }
                } else {
                    var quotesTemp: [Quote] = []
                    quotesTemp = Quote.from(jsonQuotes: json["contents"]["quotes"].arrayValue)
                    self.quotes = quotesTemp
                    self.quoteStore.updateQOTD(quote: quotesTemp[0])
                }
            case .failure (let error):
                print("\(error)")
                return
            }
        })
    }
    
    func getImageRelativeToQuoteCategory(withQuery urlQuery: String) {
        let parameters = ["client_id": SettingsRepository.unsplashApiKey, "query": urlQuery]
        Alamofire.request(UnsplashApiService.url, parameters: parameters).responseJSON(completionHandler: { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                self.imageURL = Category.getUrlToSomeImage(dURLs: json["results"][0]["urls"].dictionaryObject as! Dictionary<String, String>)
            case .failure (let error):
                print("\(error)")
                return
            }
        })
        print("from call:", self.imageURL)
    }
}
