//
//  StatsView.swift
//  MV-Project
//
//  Created by Daniel Coria on 25/08/23.
//

import SwiftUI
import WebKit

struct StatsView: UIViewRepresentable {
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        guard let magentaWeb = URL(string: "https://www.fiba.basketball/basketballworldcup/2023/game/2508/Germany-Japan#tab=overview") else { return }
        uiView.scrollView.isScrollEnabled = true
        uiView.load(URLRequest(url: magentaWeb))
    }
    
    func makeCoordinator() -> Coodinator {
        Coodinator()
    }
    
    func makeUIView(context: Context) ->  WKWebView {
        let webview = WKWebView()
        webview.uiDelegate = context.coordinator
        webview.navigationDelegate = context.coordinator
        
        let preferences = WKWebpagePreferences()
        preferences.allowsContentJavaScript = true
        preferences.preferredContentMode = .mobile
        
        webview.configuration.preferences.javaScriptCanOpenWindowsAutomatically = false
        webview.configuration.defaultWebpagePreferences = preferences
        
        return webview
    }
}

extension StatsView {
    
    class Coodinator: NSObject, WKUIDelegate, WKNavigationDelegate {
        
//        func webView(
//            _ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse,
//            decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
//                
//                guard let response = navigationResponse.response as? HTTPURLResponse,
//                      let url = response.url,
//                      response.statusCode == 200,
//                      let headers = response.allHeaderFields as? [String: String] else {
//                    decisionHandler(.cancel)
//                    return
//                }
//                
//                if let response = navigationResponse.response as? HTTPURLResponse {
//                    print(url)
//                    decisionHandler(.allow)
//                } else {
//                    decisionHandler(.cancel)
//                }
//            }
//        
//        func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
//            if (navigationAction.navigationType == .other || navigationAction.navigationType == .linkActivated) {
//                if let _ = navigationAction.request.url {
//                    decisionHandler(.allow)
//                }
//            } else {
//                decisionHandler(.cancel)
//            }
//        }
//        
//        func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
//            guard let url = webView.url else { return }
//            
//            DispatchQueue.main.async {
//                webView.load(URLRequest(url: url))
//            }
//        }
//        
    }
    
}
