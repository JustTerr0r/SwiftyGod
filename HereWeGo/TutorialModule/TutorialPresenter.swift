//
//  TutorialPresenter.swift
//  Super easy dev
//
//  Created by Finesse on 09.02.2023
//

import Foundation

protocol TutorialPresenterProtocol: AnyObject {
    func skipTutor()
    
}

class TutorialPresenter {
    weak var view: TutorialViewProtocol?
    var router: TutorialRouterProtocol
    var interactor: TutorialInteractorProtocol

    init(interactor: TutorialInteractorProtocol, router: TutorialRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
    
}

extension TutorialPresenter: TutorialPresenterProtocol {
    func skipTutor() {
        router.dismissIt()
    }
    
    
}
