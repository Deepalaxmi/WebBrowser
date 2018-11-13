//
//  String.swift
//  webBrowser
//
//  Created by Khangembam Deepalaxmi Devi on 13/11/18.
//  Copyright © 2018 Khangembam Deepalaxmi Devi. All rights reserved.
//

import Foundation
import UIKit

extension String {
    func isValidUrl() -> Bool {
        guard let url = URL(string: self) else {
            return false
        }
        if UIApplication.shared.canOpenURL(url){
            return true
        }else{
            return false
        }
    }
}
