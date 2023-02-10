//
//  TutorialViewController.swift
//  Super easy dev
//
//  Created by Finesse on 09.02.2023
//

import UIKit

protocol TutorialViewProtocol: AnyObject {
}

class TutorialViewController: UIViewController {
    // MARK: - Public
    var presenter: TutorialPresenterProtocol?

    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }
}

// MARK: - Private functions
private extension TutorialViewController {
    func initialize() {

    }
}

// MARK: - TutorialViewProtocol
extension TutorialViewController: TutorialViewProtocol {
}
