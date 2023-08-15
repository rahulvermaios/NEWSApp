//
//  WebViewController.swift
//  NewsApp
//
//  Created by rahulverma on 14/8/23.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKNavigationDelegate {

    @IBOutlet weak var headerLabel : UILabel?
    @IBOutlet weak var webView : WKWebView?
    
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!

    
    var newsType : String?
    var contentUrl : String?
   
    
    override func viewDidLoad() {
        super.viewDidLoad()

        headerLabel?.text = "\(newsType!)"
        
        webView?.navigationDelegate = self
        
        // Load content into the WKWebView
        if let url = URL(string: contentUrl ?? "") {
                   let request = URLRequest(url: url)
            webView!.load(request)
               }
        
        // Do any additional setup after loading the view.
    }
    
    
    // MARK: - IBAction
    
    @IBAction func backBtnCLicked (sender:AnyObject) {
        
        self.navigationController?.popViewController(animated: true)
    }

    
    // MARK: - WKNavigation delegate
       func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
//           DispatchQueue.main.async { [weak self] in
               activityIndicatorView.startAnimating()
//           }
       }

       func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
//           DispatchQueue.main.async { [weak self] in
               activityIndicatorView.stopAnimating()
//       }
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
