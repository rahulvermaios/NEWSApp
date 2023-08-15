//
//  ViewController.swift
//  NewsApp
//
//  Created by rahulverma on 14/8/23.
//

import UIKit



class ViewController: UIViewController {

    private let newsTypeArr : [String] = ["Top headlines in the US", "Top headlines from BBC News", "Top business headlines from Germany", "Top headlines about Trump"]
    
    // MARK: - Variables
    private var viewModel = HeadlineViewModel()
    
    @IBOutlet var tableView: UITableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureClass()
        callAPIToFetchNEWS()
        // Do any additional setup after loading the view.
    }

    func configureClass() {
        
        let nib = UINib(nibName: "NEWSTableViewCell", bundle: nil)
        tableView?.register(nib, forCellReuseIdentifier: "NEWSTableViewCell")
//        tableView?.register(NEWSTableViewCell.self, forCellReuseIdentifier: "NEWSTableViewCell")
//        tableView?.register(UINib(nibName: "NEWSTableViewCell", bundle: nil), forCellReuseIdentifier: "NEWSTableViewCell")
        
    }
    
    func callAPIToFetchNEWS() {
        
        viewModel.products.removeAllObjects()
        
        // Create a DispatchGroup
        let group = DispatchGroup()

        let apiURLs = [
            "https://newsapi.org/v2/top-headlines?country=us&apiKey=\(KeyValue.APIKey.rawValue)",
            "https://newsapi.org/v2/top-headlines?sources=bbc-news&apiKey=\(KeyValue.APIKey.rawValue)",
            "https://newsapi.org/v2/top-headlines?country=de&category=business&apiKey=\(KeyValue.APIKey.rawValue)",
            "https://newsapi.org/v2/top-headlines?q=trump&apiKey=\(KeyValue.APIKey.rawValue)"
        ]

        for url in apiURLs {
            
            group.enter()
            
            viewModel.fetchProducts(urlStr: url, result: { [unowned self] result, error in
                
                if result == "Success" {   } else {
                    print(error)
                }
                group.leave()
            })
            
        }

        // Notify the group when all tasks are completed
        group.notify(queue: .main) {
            
            DispatchQueue.main.async {
                
                self.tableView?.reloadData()
            }
        }
    }

}

extension ViewController : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 100
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return viewModel.products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "NEWSTableViewCell", for: indexPath) as! NEWSTableViewCell
        
        if let articleCount = (viewModel.products.object(at: indexPath.row) as? HeadlineJSONModel)?.totalResults {
            
            cell.articleCount?.text = "Total article (\(articleCount))"
        }
        
        cell.newsLabel?.text = newsTypeArr[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let detailView = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController {
            
            if let data = (viewModel.products.object(at: indexPath.row) as? HeadlineJSONModel)?.articles {
                
                detailView.articleData = data
            }
            
            detailView.newsType = newsTypeArr[indexPath.row]
            self.navigationController?.pushViewController(detailView, animated: true)
        }
    }
    
    
}

