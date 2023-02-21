//
//  CustomizeViewController.swift
//  Super easy dev
//
//  Created by Finesse on 20.02.2023
//

import UIKit
import MCEmojiPicker

protocol CustomizeViewProtocol: AnyObject {
}

class CustomizeViewController: UIViewController, MCEmojiPickerDelegate {

    func didGetEmoji(emoji: String) {
        defaults.set(emoji, forKey: "Userpick")
        userpick = emoji
        print(userpick)
        defaults.synchronize()
    }
    
    // MARK: - IBOutlets
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var showButton: UIButton!
    
    // MARK: - Public
    var presenter: CustomizePresenterProtocol?
    let defaults = UserDefaults()
    var userpick = ""
    var parentVC: ViewController?
        

    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
}

// MARK: - Private functions
private extension CustomizeViewController {
    func initialize() {
        cancelButton.addTarget(self, action: #selector(skip), for: .touchUpInside)
        showButton.addTarget(self, action: #selector(selectEmojiAction), for: .touchUpInside)
    }
    
    @objc func skip() {
        presenter?.cancelAction()
    }
    
    @objc private func selectEmojiAction(_ sender: UIButton) {
        let viewController = MCEmojiPickerViewController()
        viewController.delegate = self
        viewController.sourceView = sender
        present(viewController, animated: true)
    }
}

// MARK: - CustomizeViewProtocol
extension CustomizeViewController: CustomizeViewProtocol {
}
