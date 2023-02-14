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
    
    @IBOutlet weak var smallUserpickButton: UIButton!
    @IBOutlet weak var backgroundViewForSmallLabel: UIView!
    @IBOutlet private weak var userpickLabelSmall: UILabel!
    @IBOutlet private weak var userpickLabelBig: UILabel!
    @IBOutlet private weak var mainMenu: UITableView!
    @IBOutlet private weak var helloLabel: UILabel!
    
    //MARK: - Variables
    let defaults = UserDefaults.standard

    let helloGenerator = HelloGenerator() // Entity for generate Hello-word on a 100+ lang
    
    var userpick: String = "⭐️"
        
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
    
    private func setUserpick() {
        userpick = defaults.string(forKey: "Userpick") ?? "⭐️"
        let isUserPickBig = defaults.bool(forKey: "isUserPickBig")
        
        if isUserPickBig {
            userpickLabelSmall.isHidden = true
            backgroundViewForSmallLabel.isHidden = true
            userpickLabelBig.isHidden = false
            userpickLabelBig.font = .systemFont(ofSize: 55)
        } else {
            userpickLabelSmall.isHidden = false
            backgroundViewForSmallLabel.isHidden = false
            userpickLabelBig.font = .systemFont(ofSize: 0) // Hide big label for smooth animate action
        }

        userpickLabelBig.text = userpick
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
        
        let fromValues = forShow ?  [10, 100] : [55, 10]
        let toValues = forShow ?  [55, 10] : [1, 100]
         
        let animation = ValueAnimator.animate(
            props: ["h", "w"],
            from: fromValues,
            to: toValues,
            duration: 1,
            easing: EaseSine.easeInOut(),
            onChanged: { p, v in
                if p == "h" {
                    self.userpickLabelBig.font = .systemFont(ofSize: v.value)
                } else {
                    self.userpickLabelBig.alpha = v.value
                }
            })
        animation.resume()
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

        switchUserpick()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 54
    }
}
