//
//  UILabel.swift
//  HereWeGo
//
//  Created by Finesse on 13.02.2023.
//

import UIKit

extension UILabel {
  /// Animate font size from a given anchor point of the label.
  /// - Parameters:
  ///   - duration: Animation measured in seconds
  ///   - anchorPointX: 0 = left, 0.5 = center, 1 = right
  ///   - anchorPointY: 0 = top, 0.5 = center, 1 = bottom
  func setAnimatedFont(_ font: UIFont, duration: TimeInterval, anchorPointX: CGFloat, anchorPointY: CGFloat) {
    guard let oldFont = self.font else { return }

    setAnchorPoint(CGPoint(x: anchorPointX, y: anchorPointY))
    self.font = font

    let scaleFactor = oldFont.pointSize / font.pointSize
    let oldTransform = transform
    transform = transform.scaledBy(x: scaleFactor, y: scaleFactor)
    setNeedsUpdateConstraints()

    UIView.animate(withDuration: duration) {
      self.transform = oldTransform
      self.layoutIfNeeded()
    }
  }
}

extension UIView {
  /// Change the anchor point without moving the view's position.
  /// - Parameters:
  ///   - point: The layer's bounds rectangle.
  func setAnchorPoint(_ point: CGPoint) {
    let oldOrigin = frame.origin
    layer.anchorPoint = point
    let newOrigin = frame.origin

    let translation = CGPoint(x: newOrigin.x - oldOrigin.x, y: newOrigin.y - oldOrigin.y)
    translatesAutoresizingMaskIntoConstraints = true
    center = CGPoint(x: center.x - translation.x, y: center.y - translation.y)
  }
}
