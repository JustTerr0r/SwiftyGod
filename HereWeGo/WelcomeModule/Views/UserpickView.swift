//
//  UserpickView.swift
//  HereWeGo
//
//  Created by Finesse on 20.02.2023.
//

import UIKit
import ValueAnimator

class UserpickView: UIView {

    var userpickEmoji = AppStatus.shared.userpick
    let backRoundedView = UIView()
    let usernameLabel = UILabel()
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    override init(frame: CGRect) {
        super.init(frame: frame)
        print("ОГО Я ЗАИНИТИЛСЯ")
        configureUsernameView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func showDown() {
        let center = self.frame.origin
        let animator = ValueAnimator.animate("some", from: backRoundedView.frame.height, to: 0, duration: 1.0,
                                             easing: EaseCircular.easeIn(),
                                             onChanged: { p, v in
            self.backRoundedView.frame = CGRect(x: center.x, y: center.y, width: v.cg, height: v.cg)
            self.usernameLabel.font = .systemFont(ofSize: v.cg)
        })
        animator.resume()
    }
    
    func showUp() {
        let center = self.frame.origin
        let animator = ValueAnimator.animate("some", from: 0, to: frame.height, duration: 1.0,
                                             easing: EaseCircular.easeIn(),
                                             onChanged: { p, v in
            self.backRoundedView.frame = CGRect(x: center.x, y: center.y, width: v.cg, height: v.cg)
            self.usernameLabel.font = .systemFont(ofSize: v.cg * 0.78)
        })
        animator.resume()
    }
    
    private func configureUsernameView() {
        setBackground()
        setUserpick()
    }
    
    private func setBackground() {
        backRoundedView.frame = self.frame
        backRoundedView.layer.cornerRadius = backRoundedView.frame.height / 2
        backRoundedView.backgroundColor = UIColor(AppStatus.shared.userpickColor)
        self.addSubview(backRoundedView)
        
    }
    
    private func setUserpick() {
        usernameLabel.text = AppStatus.shared.userpick
        usernameLabel.font = UIFont.systemFont(ofSize: backRoundedView.frame.height * 0.78)
        usernameLabel.textAlignment = .center
        backRoundedView.addSubview(usernameLabel)
        usernameLabel.translatesAutoresizingMaskIntoConstraints = false
        usernameLabel.centerXAnchor.constraint(equalTo: backRoundedView.centerXAnchor).isActive = true
        usernameLabel.centerYAnchor.constraint(equalTo: backRoundedView.centerYAnchor).isActive = true
    }
}
