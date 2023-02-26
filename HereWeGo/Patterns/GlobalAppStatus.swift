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
    let defaults = UserDefaults()

    
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
        userpick = defaults.string(forKey: "Userpick") ?? "⭐️"
        userpickColor = defaults.string(forKey: "userpickColor") ?? "#587f6f"
    }
    
    func isAppAlreadyLaunchedOnce()->Bool {
            let defaults = UserDefaults.standard
            
            if defaults.bool(forKey: "isAppAlreadyLaunchedOnce"){
                print("App already launched : \(isAppAlreadyLaunchedOnce)")
                return true
            } else{
                setDefaultCustomize(defaults: defaults)
                print("App launched first time")
                return false
            }
        }
    
    func getUserpick() -> String {
        let defaults = UserDefaults()
        userpick = defaults.string(forKey: "Userpick") ?? "⭐️"
        return userpick
    }
    
    func setUserpickColor(color: UIColor) {
        defaults.set(color.hexString, forKey: "userpickColor")
        defaults.synchronize()
        userpickColor = color.hexString ?? "#587f6f"
    }
    
    private func setDefaultCustomize(defaults: UserDefaults){
        defaults.set(true, forKey: "isAppAlreadyLaunchedOnce")
        defaults.set("⭐️", forKey: "Userpick")
        defaults.set("#587f6f", forKey: "userpickColor")
    }
}
