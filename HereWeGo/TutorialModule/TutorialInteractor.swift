//
//  TutorialInteractor.swift
//  Super easy dev
//
//  Created by Finesse on 09.02.2023
//

protocol TutorialInteractorProtocol: AnyObject {
}

class TutorialInteractor: TutorialInteractorProtocol {
    weak var presenter: TutorialPresenterProtocol?
}
