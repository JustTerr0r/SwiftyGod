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
    var isNetworkAlertShown = false
    var isUserpickSmall: Bool
    var userpick: String
    var userpickColor: String
    
    func checkConnection(){
        
        if InternetConnectionManager.isConnectedToNetwork(){
            AppStatus.shared.isOnline = true
        }else{
            AppStatus.shared.isOnline = false
        }
    }
    
    private init() {
        let keychain = KeychainSwift()
        let defaults = UserDefaults()
        isUserpickSmall = keychain.getBool("isUserpickSmall") ?? true
        userpick = defaults.string(forKey: "Userpick") ?? "⭐️"
        userpickColor = defaults.string(forKey: "userpickColor") ?? "#587f6f"
        
        print(userpick)
    }
    
    func isAppAlreadyLaunchedOnce()->Bool {
            let defaults = UserDefaults.standard
            
            if defaults.bool(forKey: "isAppAlreadyLaunchedOnce"){
                print("App already launched : \(isAppAlreadyLaunchedOnce)")
                return true
            } else{
                defaults.set(true, forKey: "isAppAlreadyLaunchedOnce")
                defaults.set("⭐️", forKey: "Userpick")
                defaults.set("#587f6f", forKey: "userpickColor")
                print("App launched first time")
                return false
            }
        }
}
