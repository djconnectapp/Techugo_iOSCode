//
//  TermsServiceWebViewVC.swift
//  DJConnect
//
//  Created by Techugo on 26/08/22.
//  Copyright © 2022 mac. All rights reserved.
//

import UIKit
import WebKit
import Alamofire
import AlamofireObjectMapper

class TermsServiceWebViewVC: UIViewController,UIWebViewDelegate,WKUIDelegate,WKNavigationDelegate {
    
    
    @IBOutlet weak var termServiceWebVw: WKWebView!
    
    
    @IBOutlet weak var backBtn: UIButton!
    
    @IBAction func backBtnTapped(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        termServiceWebVw.navigationDelegate = self
        
        Loader.shared.show()
        let url = URL (string: "https://djconnectapp.com/terms-conditions.html")
        let requestObj = URLRequest(url: url!)
        self.termServiceWebVw.load(requestObj)

    }
    
    
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        //Loader.shared.show()
        Loader.shared.hide()
        }
        
        func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
            Loader.shared.hide()
        }
    
    
}
