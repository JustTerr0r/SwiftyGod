//
//  TutorialModuleBuilder.swift
//  Super easy dev
//
//  Created by Finesse on 09.02.2023
//

import UIKit

class TutorialModuleBuilder {
    static func build() -> TutorialViewController {
        let interactor = TutorialInteractor()
        let router = TutorialRouter()
        let presenter = TutorialPresenter(interactor: interactor, router: router)
        let storyboard = UIStoryboard(name: "TutorialViewController", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "Tutorial") as! TutorialViewController
        presenter.view  = viewController
        viewController.presenter = presenter
        interactor.presenter = presenter
        router.viewController = viewController
        return viewController
    }
}
