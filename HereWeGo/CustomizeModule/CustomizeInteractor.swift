//
//  CustomizeInteractor.swift
//  Super easy dev
//
//  Created by Finesse on 20.02.2023
//

import UIKit

protocol CustomizeInteractorProtocol: AnyObject {
    func generateColors() -> [UIColor]
    func getJoJoColors() -> [UIColor]
}

class CustomizeInteractor: CustomizeInteractorProtocol {
    weak var presenter: CustomizePresenterProtocol?
    
    func generateColors() -> [UIColor] {
        var colors: [UIColor] = []
        let randomNumber = Double(Int.random(in: 1000...9999))
        let spacing = 360/1.618
        while colors.count != 8 {
            colors.append(UIColor(hue: .random(in: 0..<360), saturation: 0.8, brightness: 0.8, alpha: 1))
        }
        return colors
    }
    
    func getJoJoColors() -> [UIColor] {
        let colors: [UIColor] = [UIColor("#fce0cd"),
                                 UIColor("#f8dd7e"),
                                 UIColor("#587f6f"),
                                 UIColor("#c276ac"),
                                 UIColor("#61b9ea"),
                                 UIColor("#d2b6be"),
                                 UIColor("#c2cdc5"),
                                 UIColor("#edeae5"),
                                 UIColor("#4e4175")]                      
        return colors
    }
}
