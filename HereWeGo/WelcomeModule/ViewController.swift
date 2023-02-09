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
    @IBOutlet private weak var menuLabel: UILabel!
 
    //MARK: - VC Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }
    
    override func viewWillLayoutSubviews() {
        checkForNetworkALert()
        configureTHelloLabel()
    }

    private func configureTableView(){
        mainMenu.dataSource = self
        mainMenu.delegate = self
        mainMenu.register(UINib(nibName: "MainCell", bundle: nil), forCellReuseIdentifier: "MainCell")
    }
    
    private func checkForNetworkALert() {
        if AppStatus.shared.isOnline {
            return
        } else {
            showNetworkAlert()
        }
    }
    
    private func configureTHelloLabel(){
        let helloGenerator = HelloGenerator()
        menuLabel.text = helloGenerator.sayHello()
    }
    
    private func showNetworkAlert(){
        let alert = UIAlertController(title: "Дэмн как так",
                                      message: "Тырнета нету, аппа может не ворк как надо",
                                      preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok",
                                      style: .cancel,
                                      handler: { (_) in }))
        self.present(alert, animated: true, completion: nil)
    }
}

//MARK: - UITableView Delegates

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        12
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = mainMenu.dequeueReusableCell(withIdentifier: "MainCell", for: indexPath) as! MainCell
        cell.configure(with: "SOMe STUPID TEXT BROski")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Tapped")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            tableView.reloadData()
        }
    }
}
