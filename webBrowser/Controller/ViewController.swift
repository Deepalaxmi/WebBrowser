//
//  ViewController.swift
//  webBrowser
//
//  Created by Khangembam Deepalaxmi Devi on 13/11/18.
//  Copyright © 2018 Khangembam Deepalaxmi Devi. All rights reserved.
//
//Screen 1 : Web Browser
import UIKit
import WebKit

struct Constant {
    struct wkWebView {
        static let estimatedProgress = "estimatedProgress"
        static let title = "title"
        static let url = "url"
        static let loading = "loading"
    }
    struct userDefault {
        static let bookmark = "bookmark"
    }
}

class ViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var progressBarView: UIProgressView!
    @IBOutlet weak var bookmarkButton: UIButton!
    @IBOutlet weak var forwardButton: UIButton!
    
    var bookmarkList: [WebPage] = []
    var backPressCount = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        initialSetUp()
    }
    
    func initialSetUp() {
        webView.navigationDelegate = self
        webView.addObserver(self, forKeyPath: Constant.wkWebView.estimatedProgress , options: .new, context: nil)
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.url), options: .new, context: nil)
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.isLoading), options: .new, context: nil)
        textField.clearButtonMode = .whileEditing
        progressBarView.isHidden = true
        setBookmark(isBookMarked: false)
        self.forwardButton.isEnabled = false
        self.bookmarkList = DataManager.fetchData()
    }
    
    //Observing properties of webview in order to handle the cases while loading the web page
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == Constant.wkWebView.estimatedProgress {
            progressBarView.isHidden = webView.estimatedProgress == 1 ? true : false
            progressBarView.setProgress(Float(webView.estimatedProgress), animated: true)
        }
        
        if keyPath?.lowercased() == Constant.wkWebView.url {
            if bookmarkList.contains(where: { (webPageObj) -> Bool in
                webPageObj.urlString == webView.url?.absoluteString
            }) {
                setBookmark(isBookMarked: true)
            }else{
                setBookmark(isBookMarked: false)
            }
        }
        
        if keyPath == Constant.wkWebView.loading {
            self.forwardButton.isEnabled = webView.canGoForward
        }
    }
    
    func loadURL(urlString: String) {
        if let url = URL(string: urlString){
            let urlRequest = URLRequest(url: url)
            webView.load(urlRequest)
        }
    }
    
    func searchString(searchText: String) {
        guard let queryString = searchText.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else{
            return
        }
        let searchString = "https://www.google.com/search?q=" + queryString
        loadURL(urlString: searchString)
        
    }
    
    //Helper functions to show alert and toast
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func showToast( message : String, seconds: Double) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.view.backgroundColor = UIColor.black
        alert.view.alpha = 0.6
        alert.view.layer.cornerRadius = 15
        
        self.present(alert, animated: true)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + seconds) {
            alert.dismiss(animated: true)
        }
    }
    
    func setBookmark(isBookMarked: Bool){
        let title = isBookMarked ? "Bookmarked" : "Bookmark"
        let backgroundColor = isBookMarked ? #colorLiteral(red: 0, green: 0.5694751143, blue: 1, alpha: 1) : #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        let titleTextColor = isBookMarked ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) : #colorLiteral(red: 0, green: 0.5694751143, blue: 1, alpha: 1)
        self.bookmarkButton.setTitle(title, for: .normal)
        self.bookmarkButton.backgroundColor = backgroundColor
        self.bookmarkButton.setTitleColor(titleTextColor, for: .normal)

    }
    
    
}

//MARK: IBOutlet Action
extension ViewController{
    
    @IBAction func goButtonPressed(_ sender: UIButton) {
        textField.resignFirstResponder()
        guard textField.hasText, let searchText = textField.text else {
            return
        }
        progressBarView.setProgress(0.0, animated: false)
        progressBarView.isHidden = false
        
        let augmentedSearchText = "http://www." + searchText
        if searchText.isValidUrl(){
            loadURL(urlString: searchText)
        }else if searchText.hasPrefix("www.") {
            loadURL(urlString: "http://" + searchText)
        }else if searchText.contains(".") && augmentedSearchText.isValidUrl() {
            loadURL(urlString: augmentedSearchText)
        }
        else{
            print("not valid url")
            searchString(searchText: searchText)
        }
        
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        guard webView.canGoBack else {
            // In iOS, the user presses the Home button to close applications. Apple never recommend to quit an iOS app programmatically.
            backPressCount += 1
            if backPressCount < 2 {
                showToast( message: "Press again to exit.", seconds: 1.0)                
            }else{
                // home button pressed programmatically - to thorw app to background
                UIControl().sendAction(#selector(URLSessionTask.suspend), to: UIApplication.shared, for: nil)
                // terminaing app in background
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
                    exit(EXIT_SUCCESS)
                })
            }
            return
        }
        backPressCount = 0
        webView.goBack()
    }
    
    @IBAction func forwardButtonPressed(_ sender: UIButton) {
        webView.goForward()
    }
    
    @IBAction func bookmarkButtonPressed(_ sender: UIButton) {
        guard webView.url != nil else {
            return
        }
        if bookmarkList.contains(where: { (webPageObj) -> Bool in
            webPageObj.urlString == webView.url?.absoluteString
        }) {
            bookmarkList.removeAll { (obj) -> Bool in
                obj.urlString == webView.url?.absoluteString
            }
            setBookmark(isBookMarked: false)
            
        }else{
            let currentWebPageObj = WebPage(title: webView.title ?? "Default title", urlString: webView.url?.absoluteString ?? "Default url")
            bookmarkList.append(currentWebPageObj)
            setBookmark(isBookMarked: true)
        }
        
        DataManager.saveData(bookmarkDataList: bookmarkList)
    }
    
    @IBAction func menuBarButtonPressed(_ sender: UIBarButtonItem) {
        let alertActionsheet = UIAlertController(title: "Menu option", message: nil, preferredStyle: .actionSheet)
        let bookmarkAction = UIAlertAction(title: "All Bookmarks", style: .default) { (action) in
            let vc = BookmarkViewController()
            vc.bookmarkDataSourceArray = self.bookmarkList
            vc.delegate = self
            self.navigationController?.pushViewController(vc, animated: true)
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertActionsheet.addAction(bookmarkAction)
        alertActionsheet.addAction(cancel)
        if let popoverController = alertActionsheet.popoverPresentationController {
            popoverController.sourceView = self.view
            popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
            popoverController.permittedArrowDirections = []
        }
        self.present(alertActionsheet, animated: true, completion: nil)
    }
}

//MARK: WKNavigationDelegate
//Handling error and resetting the progess
extension ViewController: WKNavigationDelegate{
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        showAlert(title: "Alert", message: error.localizedDescription)
        
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        progressBarView.setProgress(0.0, animated: false)
    }
}

//MARK: BookmarkViewControllerDelegate
//Handling the communication back from All Bookmark screen 2 to web Browser screen 1
extension ViewController: BookmarkViewControllerDelegate{
    func didSelect(selectedWebpage: WebPage) {
//        print(selectedWebpage.title)
        loadURL(urlString: selectedWebpage.urlString)
    }
    
}

