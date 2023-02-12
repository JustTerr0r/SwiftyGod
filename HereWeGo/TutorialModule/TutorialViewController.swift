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
    
    
    @IBOutlet weak var tutorialCollection: UICollectionView!
    @IBOutlet weak var skipButton: UIButton!
    
    // MARK: - Public
    var presenter: TutorialPresenterProtocol?
    
    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
    }
}

// MARK: - Private functions
private extension TutorialViewController {
    func initialize() {
        configureButton()
        configureCollectionView()
    }
    
    func configureCollectionView(){
        tutorialCollection.dataSource = self
        tutorialCollection.delegate = self
        tutorialCollection.register(TutorialCell.self, forCellWithReuseIdentifier: "TutorialCell")
    }
    
    func configureButton(){
        skipButton.addTarget(self,
                             action: #selector(skip),
                             for: .touchUpInside)
    }
    
    @objc func skip() {
        presenter?.skipTutor()
    }
}

// MARK: - TutorialViewProtocol
extension TutorialViewController: TutorialViewProtocol {
    
}

extension TutorialViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TutorialCell", for: indexPath) as! TutorialCell
        cell.label.text = "Item \(indexPath.item)"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width * 0.8989
        let height = view.frame.height * 0.7
        return CGSize(width: width, height: height)
    }
}
