//
//  ViewController.swift
//  HereWeGo
//
//  Created by Finesse on 07.02.2023.
//

import UIKit
import ValueAnimator

class ViewController: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet private weak var userpickLabelSmall: UILabel!
    @IBOutlet private weak var userpickLabelBig: UILabel!
    @IBOutlet private weak var mainMenu: UITableView!
    @IBOutlet private weak var helloLabel: UILabel!
    
    //MARK: - Variables
    let defaults = UserDefaults.standard

    let helloGenerator = HelloGenerator() // Entity for generate Hello-word on a 100+ lang
    
    var userpick = "⭐️"
        
    //MARK: - VC Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        configureTableView()
        setUserpick()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configureTHelloLabel()
    }
    
    override func viewWillLayoutSubviews() {
        checkForNetworkALert()
 //       setUserpick()
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
    
    private func configureUserpickSize() {
  
    }
    
    private func setUserpick() {
        let isUserPickBig = defaults.bool(forKey: "isUserPickBig")
        
        if isUserPickBig {
            userpickLabelSmall.isHidden = true
            userpickLabelBig.isHidden = false
            userpickLabelBig.font = .systemFont(ofSize: 55)
        } else {
            userpickLabelSmall.isHidden = false
            userpickLabelBig.isHidden = true
            userpickLabelBig.font = .systemFont(ofSize: 17)
        }

        userpickLabelBig.text = userpick
        userpickLabelSmall.text = userpick
    }
    
    private func switchUserpick(isUserpickBig: Bool) {
        if isUserpickBig {
            self.userpickLabelBig.isHidden = false
            let animator = ValueAnimator.animate("some", from: 15, to: 48, duration: 1.0,
                                                 easing: EaseCircular.easeIn(), onChanged: { p, v in
                self.userpickLabelBig.font = .systemFont(ofSize: v.value)
            })
            animator.resume()
        } else {
            let animator = ValueAnimator.animate("some", from: 48, to: 11, duration: 1.0,
                                                 easing: EaseCircular.easeIn(), onChanged: { p, v in
                self.userpickLabelBig.font = .systemFont(ofSize: v.value)
            })
            animator.resume()
            animator.endCallback = {
                self.userpickLabelBig.isHidden = true
                self.userpickLabelBig.font = .systemFont(ofSize: 15)
            }
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
        let isUserPickBig = !defaults.bool(forKey: "isUserPickBig")
        defaults.set(isUserPickBig, forKey: "isUserPickBig")
        defaults.synchronize()
//        setUserpick()
        switchUserpick(isUserpickBig: isUserPickBig)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
}
