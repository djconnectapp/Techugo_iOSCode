//
//  AddStripeAccountVC.swift
//  DJConnect
//
//  Created by Techugo on 01/08/22.
//  Copyright © 2022 mac. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper
import Stripe
import WebKit

class AddStripeAccountVC: UIViewController,UIWebViewDelegate,WKUIDelegate,WKNavigationDelegate {

    @IBOutlet weak var withdrawWebView: WKWebView!
    
    var getStripeUrlStr = String()
    
    var callbackWithdrawSucess : ((_ withdraw: String) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        withdrawWebView.navigationDelegate = self
        withdrawWebView.uiDelegate = self
        
        let url = URL (string: getStripeUrlStr)
        let requestObj = URLRequest(url: url!)
        self.withdrawWebView.load(requestObj)

    }
    
    @IBAction func backBtnTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        Loader.shared.show()
       // Loader.shared.hide()
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        Loader.shared.hide()
        if let url = webView.url?.absoluteString{
            print(url)
            //self.withdrawWebView.isHidden = true
            //Loader.shared.hide()
        }
        print("weburl",webView.url?.absoluteString ?? "")
    }
    
    func webView(_ webView: WKWebView, didFailLoadWithError error: Error) {
        print(error.localizedDescription)
    }
    func webViewDidFinishLoad(_ webView: WKWebView) {
        
        print("webViewDidFinishLoad")
    }
    func webViewDidStartLoad(_ webView: WKWebView) {
        print("webViewDidStartLoad")
    }
    
    func webView(
            _ webView: WKWebView,
            decidePolicyFor navigationAction: WKNavigationAction,
            decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {

            guard let url = navigationAction.request.url else {
                decisionHandler(.allow)
                return
            }

           if url.absoluteString.contains("adminpanel/login") {
                // this means login successful
                decisionHandler(.cancel)
               if let call = callbackWithdrawSucess{
                   call("withdrawSuccess")
                   self.navigationController?.popViewController(animated: true)
               }
               // _ = self.navigationController?.popViewController(animated: false)
               
            }
            else {
                decisionHandler(.allow)
            }
        }
    
}
