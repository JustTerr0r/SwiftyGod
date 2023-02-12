//
//  GlobalAppStatus.swift
//  HereWeGo
//
//  Created by Finesse on 07.02.2023.
//
// MARK: - Singleton

import UIKit
import KeychainSwift

final class AppStatus {
    
    static let shared = AppStatus()
    
    var isOnline: Bool = true
    var isUserpickSmall: Bool
    
    func checkConnection(){
        
        if InternetConnectionManager.isConnectedToNetwork(){
            AppStatus.shared.isOnline = true
        }else{
            AppStatus.shared.isOnline = false
        }
    }
    
    private init() {
        let keychain = KeychainSwift()
        isUserpickSmall = keychain.getBool("isUserpickSmall") ?? true
    }
    
    func isAppAlreadyLaunchedOnce()->Bool {
            let defaults = UserDefaults.standard
            
            if defaults.bool(forKey: "isAppAlreadyLaunchedOnce"){
                print("App already launched : \(isAppAlreadyLaunchedOnce)")
                return true
            }else{
                defaults.set(true, forKey: "isAppAlreadyLaunchedOnce")
                print("App launched first time")
                return false
            }
        }
}
