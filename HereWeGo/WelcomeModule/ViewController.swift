//
//  ViewController.swift
//  HereWeGo
//
//  Created by Finesse on 07.02.2023.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet private weak var mainMenu: UITableView!
    @IBOutlet private weak var helloLabel: UILabel!
    
    //MARK: - Variables
    let helloGenerator = HelloGenerator() // Entity for generate Hello-word on a 100+ lang
    
    //MARK: - VC Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        configureTableView()
    }
    
    override func viewWillLayoutSubviews() {
        checkForNetworkALert()
        configureTHelloLabel()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
    }
    
    private func configureTableView() {
        mainMenu.dataSource = self
        mainMenu.delegate = self
        mainMenu.register(UINib(nibName: "MainCell", bundle: nil), forCellReuseIdentifier: "MainCell")
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
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) { [weak self] in
            self?.reHelloAction()
        }
    }
    
    private func showNetworkAlert() {
        let alert = UIAlertController(title: "Дэмн как так",
                                      message: "Тырнета нету, аппа может не ворк как надо",
                                      preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok",
                                      style: .cancel,
                                      handler: { (_) in }))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func reHelloAction() {
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
        let vc = TutorialModuleBuilder.build()
        navigationController?.pushViewController(vc, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
}
