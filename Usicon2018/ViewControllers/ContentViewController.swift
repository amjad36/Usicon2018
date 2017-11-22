//
//  ContentViewController.swift
//  Usicon2018
//
//  Created by Amjad Khan on 22/11/17.
//  Copyright © 2017 JTEGroup. All rights reserved.
//

import UIKit
import WebKit

class ContentViewController: UIViewController, WKNavigationDelegate {

    @IBOutlet weak var forwardButton: UIBarButtonItem!
    @IBOutlet weak var reloadButton: UIBarButtonItem!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var webView: WKWebView!
    var item: Item?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = item?.title
        
        if let urlString = item?.destinatonUrl {
            if let url = URL(string: urlString) {
                let request = URLRequest(url: url)
                webView.load(request)
                webView.navigationDelegate = self
            }
        }
        
        view.insertSubview(webView, belowSubview: progressView)
    }
    
    //MARK: WKNavigationDelegate
    
    @IBAction func back(sender: UIBarButtonItem) {
        webView.goBack()
    }
    
    @IBAction func forward(sender: UIBarButtonItem) {
        webView.goForward()
    }
    
    @IBAction func reload(sender: UIBarButtonItem) {
        if let urlStr = webView.url {
            let request = URLRequest(url:urlStr)
            webView.load(request)
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if (keyPath == "loading") {
            backButton.isEnabled = webView.canGoBack
            forwardButton.isEnabled = webView.canGoForward
        }
        if (keyPath == "estimatedProgress") {
            progressView.isHidden = webView.estimatedProgress == 1
            progressView.setProgress(Float(webView.estimatedProgress), animated: true)
        }
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        progressView.setProgress(0.0, animated: false)
    }
}
