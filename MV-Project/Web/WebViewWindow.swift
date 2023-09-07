//
//  WebViewWindow.swift
//  MV-Project
//
//  Created by Daniel Coria on 25/08/23.
//

import SwiftUI
import WebKit

struct WebViewWindow: UIViewRepresentable {
        
    let webview = WKWebView()
//    @Binding var isPresentingSpace: Bool
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        guard let magentaWeb = URL(string: "https://web.magentatv.de") else { return }
        uiView.scrollView.isScrollEnabled = true
        uiView.load(URLRequest(url: magentaWeb))
    }
    
    func makeCoordinator() -> Coodinator {
        Coodinator(self, isPresentingSpace: false)
    }
    
    func makeUIView(context: Context) ->  WKWebView {
        webview.uiDelegate = context.coordinator
        webview.navigationDelegate = context.coordinator
        
        let preferences = WKWebpagePreferences()
        preferences.allowsContentJavaScript = true
        preferences.preferredContentMode = .desktop
        
        webview.configuration.preferences.javaScriptCanOpenWindowsAutomatically = false
        webview.configuration.defaultWebpagePreferences = preferences
        context.coordinator.addWebViewObserver()
        
        return webview
    }
}

extension WebViewWindow {
    
    class Coodinator: NSObject, WKUIDelegate, WKNavigationDelegate {
        var parent: WebViewWindow
        var isPresentingSpace: Bool
        
        @Environment(\.openWindow) private var openWindow
        @Environment(\.dismissWindow) private var dismissWindow
        
        @Environment(\.openImmersiveSpace) var openImmersiveSpace
        @Environment(\.dismissImmersiveSpace) var dismissImmersiveSpace
        
        let path = "https://web.magentatv.de/serie/fiba-basketball-wm-2023/staffel-00/DMM_SEASON_37585"
        
        init(_ parent: WebViewWindow, isPresentingSpace: Bool) {
            self.parent = parent
            self.isPresentingSpace = isPresentingSpace
        }
        
        // Observe WKWebview
        func addWebViewObserver() {
            parent.webview.addObserver(self, forKeyPath: "URL", options: .new, context: nil)
        }
        
        override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
            if object as AnyObject? === parent.webview && keyPath == "URL" {
                print("URL Change 1:", parent.webview.url?.absoluteString ?? "No value provided")
                if parent.webview.url?.absoluteString == path {
                    Task {
                        if isPresentingSpace {
                            // Dismiss the space and return the user to their real-world space.
                            await dismissImmersiveSpace()
                            dismissWindow(id: "StatsView")
                            dismissWindow(id: "Object")
                            isPresentingSpace = false
                        } else {
                            // Await the request to open the destionation and set the state accordingly.
                            switch await openImmersiveSpace(id: "ImmersiveSpace") {
                            case .opened:
                                openWindow(id: "StatsView")
                                openWindow(id: "Object")
                                isPresentingSpace = true
                            default: 
                                dismissWindow(id: "StatsView")
                                dismissWindow(id: "Object")
                                isPresentingSpace = false
                            }
                            
                        }
                    }
                } else if parent.webview.url?.absoluteString != path {
//                    Task {
//                        await dismissImmersiveSpace()
//                        dismissWindow(id: "StatsView")
//                        dismissWindow(id: "Object")
//                    }
                }
            }
        }
        
        func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
            
            if let response = navigationResponse.response as? HTTPURLResponse, let url = response.url {
                if response.statusCode == 401 {
                    decisionHandler(.cancel)
                } else {
                    decisionHandler(.allow)
                }
            } else {
                decisionHandler(.cancel)
            }
        }
        
        func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
            if navigationAction.navigationType == .linkActivated  {
                    decisionHandler(.cancel)
            } else {
                print("not a user click")
                if navigationAction.navigationType == .linkActivated {
                    if let _ = navigationAction.request.url {
                        decisionHandler(.allow)
                    }
                } else if navigationAction.navigationType == .other {
                    if let _ = navigationAction.request.url {
                        decisionHandler(.allow)
                    }
                } else {
                    decisionHandler(.cancel)
                }
            }
        }
        
        func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
            guard let url = webView.url else { return }
            DispatchQueue.main.async {
                webView.load(URLRequest(url: url))
            }
        }
        
        func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
            // Intercept target=_blank links
            guard
                navigationAction.targetFrame == nil,
                let url = navigationAction.request.url else {
                return nil
            }
            
            let request = URLRequest(url: url)
            webView.load(request)
            
            return nil
        }
        
        
    }
    
}
