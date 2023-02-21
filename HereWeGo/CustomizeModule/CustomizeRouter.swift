//
//  CustomizeRouter.swift
//  Super easy dev
//
//  Created by Finesse on 20.02.2023
//

import UIKit

protocol CustomizeRouterProtocol {
    func dismissIt()
}

class CustomizeRouter: CustomizeRouterProtocol {
    weak var viewController: CustomizeViewController?
    
    @objc func dismissIt(){
        viewController?.dismiss(animated: true, completion: {self.viewController?.parentVC?.setUserpick()})
    }
}
