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
        userpickView.configureUsernameView()
    }
    
    // MARK: - IBOutlets
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var showButton: UIButton!
    @IBOutlet weak var userpickView: UserpickView!
    @IBOutlet weak var backgroundColorPickerCollection: UICollectionView!
    @IBOutlet weak var randomizeColorsButton: UIButton!

    @IBOutlet weak var defaultColorsButton: UIButton!
    
    // MARK: - Public
    var presenter: CustomizePresenterProtocol?
    let defaults = UserDefaults()
    var userpick = ""
    var parentVC: ViewController?
    var colors: [UIColor] = []


    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

    }
}

// MARK: - Private functions
private extension CustomizeViewController {
    
    func initialize() {
        cancelButton.addTarget(self, action: #selector(skip), for: .touchUpInside)
        showButton.addTarget(self, action: #selector(selectEmojiAction), for: .touchUpInside)
        configureUserpick()
        configureColorPicker()
        colors = (presenter?.getColors())!
        randomizeColorsButton.addTarget(self, action: #selector(generateColors), for: .touchUpInside)
        defaultColorsButton.addTarget(self, action: #selector(setDefaultColors), for: .touchUpInside)

        
    }
    
    @objc func skip() {
        presenter?.cancelAction()
    }
    
    @objc func generateColors() {
        colors = (presenter?.getColors())!
        backgroundColorPickerCollection.reloadData()
    }
    
    @objc func setDefaultColors() {
        colors = (presenter?.getJoJoColors())!
        backgroundColorPickerCollection.reloadData()
    }
    
    @objc private func selectEmojiAction(_ sender: UIButton) {
        let viewController = MCEmojiPickerViewController()
        viewController.delegate = self
        viewController.sourceView = sender
        present(viewController, animated: true)
    }
    
    func configureUserpick() {
        view.layoutSubviews()
        userpickView.layoutSubviews()
        
        userpickView.awakeFromNib()
    }
    
    func configureColorPicker(){
        backgroundColorPickerCollection.delegate = self
        backgroundColorPickerCollection.dataSource = self
        backgroundColorPickerCollection.register(UINib(nibName: "ColorPickerCell", bundle: nil), forCellWithReuseIdentifier: "cell")
    }
}
// MARK: - UICollectionView Delegates

extension CustomizeViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        colors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ColorPickerCell
        
        guard colors.count > 0 else { return cell }
        
        for i in 0...indexPath.row {
            cell.backgroundColor = colors[i]
            cell.color = colors[i].hexString ?? "nil"
        }
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = collectionView.frame.height
        let width = collectionView.frame.width
        return CGSize(width: width / 4 - 4, height: height/2 - 4)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ColorPickerCell
        AppStatus.shared.setUserpickColor(color: colors[indexPath.row])
        print(AppStatus.shared.userpickColor)
        userpickView.configureUsernameView()
    }
}

// MARK: - CustomizeViewProtocol
extension CustomizeViewController: CustomizeViewProtocol {
}
