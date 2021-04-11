//
//  WebViewController.swift
//  HackerNews
//
//  Created by Elmira on 04.04.21.
//

import Foundation
import WebKit
import UIKit

class WebViewController: UIViewController {
    
    var url: String = ""
    
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let urlString = URL(string: url) else {
            return
        }
        let request = URLRequest(url: urlString)
        
        webView.load(request)
    }
    
}
