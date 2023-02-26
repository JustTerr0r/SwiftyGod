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
    }
    
    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUsernameView()

    }
    
    func showDown() {
   //     setBackgroundConstrain(active: false)
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
  //      setBackgroundConstrain(active: true)
        animator.resume()
    }
    
    func configureUsernameView() {
        userpickEmoji = AppStatus.shared.getUserpick()
        setBackground()
        setUserpick()
    }
    
    private func setBackground() {
        backgroundColor = .clear
        backRoundedView.frame = self.frame
        backRoundedView.layer.cornerRadius = backRoundedView.frame.height / 2
        backRoundedView.backgroundColor = UIColor(AppStatus.shared.userpickColor)
        self.insertSubview(backRoundedView, at: 0)
        backRoundedView.frame = self.frame
        setBackgroundConstrain(active: true)
    }
    
    private func setUserpick() {
        usernameLabel.text = AppStatus.shared.userpick
        usernameLabel.font = UIFont.systemFont(ofSize: backRoundedView.frame.height * 0.7)
        usernameLabel.textAlignment = .center
        self.addSubview(usernameLabel)
        usernameLabel.translatesAutoresizingMaskIntoConstraints = false
        usernameLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        usernameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    
    private func setBackgroundConstrain(active: Bool){
        backRoundedView.translatesAutoresizingMaskIntoConstraints = !active
        backRoundedView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = active
        backRoundedView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = active
        backRoundedView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = active
        backRoundedView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = active

    }
}
