//
//  ViewController.swift
//  HereWeGo
//
//  Created by Finesse on 07.02.2023.
//

import UIKit
import ValueAnimator
import SwiftyUI

class ViewController: UIViewController {
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var bigUserpickView: UIView!
    @IBOutlet weak var bigUserpickStackview: UIStackView!
    @IBOutlet weak var smallUserpickButton: UIButton!
    @IBOutlet weak var backgroundViewForSmallLabel: UIView!
    @IBOutlet private weak var userpickLabelSmall: UILabel!
    @IBOutlet private weak var mainMenu: UITableView!
    @IBOutlet private weak var helloLabel: UILabel!
    
    //MARK: - Variables
    let defaults = UserDefaults.standard
    
    let helloGenerator = HelloGenerator() // Entity for generate Hello-word on a 100+ lang
    
    //MARK: - VC Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        configureTableView()
        setUserpick()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configureTHelloLabel()
        configureUserpickBackground()
    }
    
    override func viewWillLayoutSubviews() {
        checkForNetworkALert()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        //     navigationController?.navigationBar.isHidden = false
    }
    
    //MARK: - Private Functions
    
    private func configureTableView() {
        mainMenu.dataSource = self
        mainMenu.delegate = self
        mainMenu.register(UINib(nibName: "MainCell", bundle: nil), forCellReuseIdentifier: "MainCell")
        mainMenu.cornerRadius = 8
    }
    
    private func configureNavigationBar() {
        navigationController?.navigationBar.isHidden = true
    }
    
    private func checkForNetworkALert() {
        if AppStatus.shared.isOnline {
            return
        } else {
            showNetworkAlert()
        }
    }
    
    private func configureTHelloLabel() {
        helloLabel.text = helloGenerator.sayHello()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.87) { [weak self] in
            self?.reHelloAction()
        }
    }
    
    private func configureUserpickBackground() {
        backgroundViewForSmallLabel.layer.cornerRadius = backgroundViewForSmallLabel.frame.height / 2
        backgroundViewForSmallLabel.backgroundColor = UIColor("#587f6f")
        smallUserpickButton.addTarget(self, action: #selector(switchUserpick), for: .touchUpInside)
    }
    
    func setUserpick() {
        let isUserPickBig = defaults.bool(forKey: "isUserPickBig")
        
        if isUserPickBig {
            userpickLabelSmall.isHidden = true
            backgroundViewForSmallLabel.isHidden = true
        } else {
            userpickLabelSmall.isHidden = false
            backgroundViewForSmallLabel.isHidden = false
        }
        
        guard let userpick = defaults.string(forKey: "Userpick") else {return}
        userpickLabelSmall.text = userpick
        
    }
    
    @objc private func switchUserpick() {
        let isUserPickBig = !defaults.bool(forKey: "isUserPickBig")
        defaults.set(isUserPickBig, forKey: "isUserPickBig")
        defaults.synchronize()
        
        animateUserpick(forShow: isUserPickBig)
        userpickLabelSmall.isHidden = isUserPickBig
        setUserpick()
    }
    
    private func animateUserpick(forShow: Bool) {
        let view = UserpickView(frame: bigUserpickView.frame)
        bigUserpickView.addSubview(view)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            view.showDown()
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                view.showUp()
            }
        }
    }
        
    private func showNetworkAlert() {
        guard !AppStatus.shared.isNetworkAlertShown else {return}
        let alert = UIAlertController(title: "Дэмн как так",
                                      message: "Тырнета нету, аппа может не ворк как надо",
                                      preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok",
                                      style: .cancel,
                                      handler: { (_) in }))
        self.present(alert, animated: true, completion: nil)
        AppStatus.shared.isNetworkAlertShown = true
    }
    
    private func reHelloAction() { // Update Hello-word
        UIView.transition(with: helloLabel, duration: 1, options: .transitionCrossDissolve, animations: {
            self.helloLabel.text = self.helloGenerator.sayHello()
        }, completion: nil)
    }
}

//MARK: - UITableView Delegates

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        12
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = mainMenu.dequeueReusableCell(withIdentifier: "MainCell", for: indexPath) as! MainCell
        cell.configure(with: "SOME STUPid TEXT BROskii", indexPath: indexPath.item)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Tapped")
        //        let vc = TutorialModuleBuilder.build()
        //        vc.modalPresentationStyle = .fullScreen
        //        present(vc, animated: true)
        if indexPath.row == 0 {
            switchUserpick()
        } else {
            let vc = CustomizeModuleBuilder.build(from: self)
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 54
    }
}
