//
//  AlertFactory.swift
//  HereWeGo
//
//  Created by Finesse on 08.02.2023.
//
//

import UIKit

protocol AlertFactoryService {
    var delegate: AlertActionDelegate? { get set }
    func build(alertData: AlertViewData) -> UIViewController
}
protocol AlertActionDelegate {
    func okAction()
    func cancelAction()
}
class AlertImplementation: AlertFactoryService {
    
    var delegate: AlertActionDelegate?
    
    func build(alertData: AlertViewData) -> UIViewController {
        let vc = UIAlertController(title: alertData.title,
                                   message: alertData.message,
                                   preferredStyle: alertData.style)
        
        if alertData.enableOkAction {
            let okAction = UIAlertAction(
                           title: alertData.okActionTitle,
                           style: alertData.okActionStyle)
            { (_) in
               self.delegate?.okAction()
            }
            vc.addAction(okAction)
        }
        
        if alertData.enableCancelAction {
            let cancelAction = UIAlertAction(
                               title: alertData.cancelActionTitle,
                               style: alertData.cancelActionStyle)
            { (_) in
               self.delegate?.cancelAction()
            }
            vc.addAction(cancelAction)
        }
        return vc
    }
}

struct AlertViewData {
    let title: String
    let message: String
    let style: UIAlertController.Style
    let enableOkAction: Bool
    let okActionTitle: String
    let okActionStyle: UIAlertAction.Style
    let enableCancelAction: Bool
    let cancelActionTitle: String
    let cancelActionStyle: UIAlertAction.Style
    
    init(title: String,
         message: String,
         style: UIAlertController.Style = .alert,
         enableOkAction: Bool,
         okActionTitle: String,
         okActionStyle: UIAlertAction.Style,
         enableCancelAction: Bool = false,
         cancelActionTitle: String,
         cancelActionStyle: UIAlertAction.Style = .cancel) {
        self.title = title
        self.message = message
        self.style = style
        self.enableOkAction = enableOkAction
        self.okActionTitle = okActionTitle
        self.okActionStyle = okActionStyle
        self.enableCancelAction = enableCancelAction
        self.cancelActionTitle = cancelActionTitle
        self.cancelActionStyle = cancelActionStyle
    }
    
    struct SimpleAlertViewData {
        let title: String
        let message: String
        let style: UIAlertController.Style
        let actionTitle: String
        let actionStyle: UIAlertAction.Style
      
        init(title: String,
             message: String,
             style: UIAlertController.Style = .alert,
             actionTitle: String,
             actionStyle: UIAlertAction.Style = .cancel) {
            self.title = title
            self.message = message
            self.style = style
            self.actionTitle = actionTitle
            self.actionStyle = actionStyle
        }
    }
}
