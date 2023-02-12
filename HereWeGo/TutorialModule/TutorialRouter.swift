//
//  TutorialRouter.swift
//  Super easy dev
//
//  Created by Finesse on 09.02.2023
//

import UIKit

protocol TutorialRouterProtocol {
    func dismissIt()
}

class TutorialRouter: TutorialRouterProtocol {
    weak var viewController: TutorialViewController?
    
    @objc func dismissIt(){
        viewController?.dismiss(animated: true)
    }
}
