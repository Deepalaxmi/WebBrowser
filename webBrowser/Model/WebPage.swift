//
//  WebPage.swift
//  webBrowser
//
//  Created by Khangembam Deepalaxmi Devi on 13/11/18.
//  Copyright © 2018 Khangembam Deepalaxmi Devi. All rights reserved.
//
//Data model class for bookmark web page
import Foundation

class WebPage: Codable {
    var title: String
    var urlString: String
    
    init(title: String, urlString: String) {
        self.title = title
        self.urlString = urlString
    }
    
}
