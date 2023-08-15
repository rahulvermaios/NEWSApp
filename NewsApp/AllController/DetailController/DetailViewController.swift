//
//  DetailViewController.swift
//  NewsApp
//
//  Created by rahulverma on 14/8/23.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet var detailTableView : UITableView!
    @IBOutlet var headerLabel : UILabel?
    
    var newsType : String?
    var articleData : [Article]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        detailTableView.estimatedRowHeight = 100
        configureClass()
        
        if articleData != nil {
                
            if let newsTypeTemp = newsType {
                
                headerLabel?.text = "\(newsTypeTemp)"
                
            } else {
                
                headerLabel?.text = "NEWS"
            }
            
           
            self.detailTableView?.delegate = self
            self.detailTableView?.dataSource = self
            
        } else {
            
            // show error
        }
        
        // Do any additional setup after loading the view.
    }
    
    func configureClass() {
       
        detailTableView?.register(UINib(nibName: "DetailCellTableViewCell", bundle: nil), forCellReuseIdentifier: "DetailCellTableViewCell")
        
        
        self.detailTableView?.reloadData()
        
    }
    
    // MARK: - IBAction
    
    @IBAction func backBtnCLicked (sender:AnyObject) {
        
        self.navigationController?.popViewController(animated: true)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


extension DetailViewController : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return articleData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailCellTableViewCell") as! DetailCellTableViewCell
        
        if let data = articleData?[indexPath.row] {
            
            cell.setupdata(article_data: data)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let webView = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "WebViewController") as? WebViewController {
            
            if let contentUrl = articleData?[indexPath.row].url {
                
                webView.contentUrl = "\(contentUrl)"
            }
            
            if let titleStr = articleData?[indexPath.row].title {
                
                webView.newsType = "\(titleStr)"
            }
            self.navigationController?.pushViewController(webView, animated: true)
        }
        
    }
    
}
