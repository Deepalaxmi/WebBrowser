//
//  DataManager.swift
//  webBrowser
//
//  Created by Khangembam Deepalaxmi Devi on 13/11/18.
//  Copyright © 2018 Khangembam Deepalaxmi Devi. All rights reserved.

// DataManager class responsible to fetch and save data in order to persist data

import Foundation

class DataManager {
    static func saveData(bookmarkDataList: [WebPage]){
        do {
            let webData = try JSONEncoder().encode(bookmarkDataList)
            UserDefaults.standard.set(webData, forKey: Constant.userDefault.bookmark)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    static func fetchData() -> [WebPage]{
        guard let bookmarkData = UserDefaults.standard.data(forKey: Constant.userDefault.bookmark) else{
            return []
        }
        do{
            let bookmarkList = try JSONDecoder().decode([WebPage].self, from: bookmarkData)
            return bookmarkList
        }catch{
            print(error.localizedDescription)
            return []
        }
    }
}

