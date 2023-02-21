//
//  CustomizePresenter.swift
//  Super easy dev
//
//  Created by Finesse on 20.02.2023
//

import UIKit
import MCEmojiPicker

protocol CustomizePresenterProtocol: AnyObject {
    func cancelAction()
}

class CustomizePresenter {
    
    let defaults = UserDefaults.standard
    var userpick: String?
    
    
    weak var view: CustomizeViewProtocol?
    var router: CustomizeRouterProtocol
    var interactor: CustomizeInteractorProtocol
    
    init(interactor: CustomizeInteractorProtocol, router: CustomizeRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
    
}

extension CustomizePresenter: CustomizePresenterProtocol {

    
    func cancelAction(){
        router.dismissIt()
    }
    
}
