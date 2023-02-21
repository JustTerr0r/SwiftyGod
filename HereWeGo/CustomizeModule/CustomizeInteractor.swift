//
//  CustomizeInteractor.swift
//  Super easy dev
//
//  Created by Finesse on 20.02.2023
//

protocol CustomizeInteractorProtocol: AnyObject {
}

class CustomizeInteractor: CustomizeInteractorProtocol {
    weak var presenter: CustomizePresenterProtocol?
}
