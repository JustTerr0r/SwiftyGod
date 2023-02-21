//
//  CustomizeModuleBuilder.swift
//  Super easy dev
//
//  Created by Finesse on 20.02.2023
//

import UIKit

class CustomizeModuleBuilder {
    static func build(from: ViewController) -> CustomizeViewController {
        let interactor = CustomizeInteractor()
        let router = CustomizeRouter()
        let presenter = CustomizePresenter(interactor: interactor, router: router)
        let storyboard = UIStoryboard(name: "Customize", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "Customize") as! CustomizeViewController
        presenter.view  = viewController
        viewController.presenter = presenter
        viewController.parentVC = from
        interactor.presenter = presenter
        router.viewController = viewController
        return viewController
    }
}
