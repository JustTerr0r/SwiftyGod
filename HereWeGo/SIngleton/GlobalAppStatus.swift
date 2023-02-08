//
//  GlobalAppStatus.swift
//  HereWeGo
//
//  Created by Finesse on 07.02.2023.
//

import UIKit


final class AppStatus {
    
    static let shared = AppStatus()
    
    var isOnline: Bool = true
    
    func checkConnection(){
        
        if InternetConnectionManager.isConnectedToNetwork(){
            AppStatus.shared.isOnline = true
        }else{
            AppStatus.shared.isOnline = false
        }
    }
    
    private init() {
        // Private initialization to ensure just one instance is created.
    }
}
