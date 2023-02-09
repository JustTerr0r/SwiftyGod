//
//  HelloManager.swift
//  HereWeGo
//
//  Created by Finesse on 08.02.2023.
//

import Foundation
import SwiftyJSON

class HelloGenerator {
    
    func sayHello() -> String {
        
    return generateHello()
    }
    
    private func generateHello() -> String{
        guard let json = try? JSON(data: readLocalFile(forName: "hello")!) else {return "no data for hello"}
        let randomHelloCounter = Int.random(in: 0...103)
        return json[randomHelloCounter]["hello"].string ?? "Hello"
    }
    
    private func readLocalFile(forName name: String) -> Data? {
        do {
            if let bundlePath = Bundle.main.path(forResource: name,
                                                 ofType: "json"),
                let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                return jsonData
            }
        } catch {
            print(error)
        }
        
        return nil
    }
}
