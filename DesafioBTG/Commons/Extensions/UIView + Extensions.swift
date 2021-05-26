//
//  UIView + Extensions.swift
//  DesafioBTG
//
//  Created by Pedro Henrique Cavalcante de Sousa on 25/05/21.
//

import UIKit

extension UIView {
    
    public func startLoading() {
        
        isUserInteractionEnabled = false
        
        let loadingView = LoadingView()
        
        addSubview(loadingView)
        loadingView.startAnimating()
        
        loadingView
            .fillSuperview()
    }
    
    public func stopLoading() {
        
        isUserInteractionEnabled = true
        
        let loadingView = viewWithTag(LoadingView.tag) as? LoadingView
        loadingView?.stopAnimating()
    }
    
}

// MARK: - Auto Layout
extension UIView {
    @discardableResult
    public func anchorVertical(top: NSLayoutYAxisAnchor? = nil,
                               bottom: NSLayoutYAxisAnchor? = nil,
                               topConstant: CGFloat = 0,
                               bottomConstant: CGFloat = 0) -> UIView {
        translatesAutoresizingMaskIntoConstraints = false

        var anchors = [NSLayoutConstraint]()

        if let top = top {
            anchors.append(topAnchor.constraint(equalTo: top, constant: topConstant))
        }

        if let bottom = bottom {
            anchors.append(bottomAnchor.constraint(equalTo: bottom, constant: -bottomConstant))
        }

        NSLayoutConstraint.activate(anchors)

        return self
    }

    @discardableResult
    public func anchorVerticalWithMultiplier(top: NSLayoutYAxisAnchor? = nil,
                                             bottom: NSLayoutYAxisAnchor? = nil,
                                             topMultiplier: CGFloat = 1,
                                             bottomMultiplier: CGFloat = 1) -> UIView {
        translatesAutoresizingMaskIntoConstraints = false

        var anchors = [NSLayoutConstraint]()

        if let top = top {
            anchors.append(topAnchor.constraint(equalToSystemSpacingBelow: top, multiplier: topMultiplier))
        }

        if let bottom = bottom {
            anchors.append(bottomAnchor.constraint(equalToSystemSpacingBelow: bottom, multiplier: -bottomMultiplier))
        }

        NSLayoutConstraint.activate(anchors)

        return self
    }

    @discardableResult
    public func anchorHorizontal(leading: NSLayoutXAxisAnchor? = nil,
                                 trailing: NSLayoutXAxisAnchor? = nil,
                                 leadingConstant: CGFloat = 0,
                                 trailingConstant: CGFloat = 0) -> UIView {
        translatesAutoresizingMaskIntoConstraints = false

        var anchors = [NSLayoutConstraint]()

        if let leading = leading {
            anchors.append(leadingAnchor.constraint(equalTo: leading, constant: leadingConstant))
        }

        if let trailing = trailing {
            anchors.append(trailingAnchor.constraint(equalTo: trailing, constant: -trailingConstant))
        }

        NSLayoutConstraint.activate(anchors)

        return self
    }

    @discardableResult
    public func anchorSize(widthConstant: CGFloat = 0, heightConstant: CGFloat = 0) -> UIView {
        translatesAutoresizingMaskIntoConstraints = false

        var anchors = [NSLayoutConstraint]()

        if widthConstant > 0 {
            anchors.append(widthAnchor.constraint(equalToConstant: widthConstant))
        }

        if heightConstant > 0 {
            anchors.append(heightAnchor.constraint(equalToConstant: heightConstant))
        }

        NSLayoutConstraint.activate(anchors)

        return self
    }

    @discardableResult
    public func anchorSize(width: NSLayoutDimension? = nil,
                           widthConstant: CGFloat = 0,
                           height: NSLayoutDimension? = nil,
                           heightConstant: CGFloat = 0) -> UIView {
        translatesAutoresizingMaskIntoConstraints = false

        var anchors = [NSLayoutConstraint]()

        if let width = width {
            anchors.append(widthAnchor.constraint(equalTo: width, constant: widthConstant))
        }

        if let height = height {
            anchors.append(heightAnchor.constraint(equalTo: height, constant: heightConstant))
        }

        NSLayoutConstraint.activate(anchors)

        return self
    }

    @discardableResult
    public func anchorSizeWithMultiplier(width: NSLayoutDimension? = nil,
                                         widthMultiplier: CGFloat = 1,
                                         height: NSLayoutDimension? = nil,
                                         heightMultiplier: CGFloat = 1) -> UIView {
        translatesAutoresizingMaskIntoConstraints = false

        var anchors = [NSLayoutConstraint]()

        if let width = width {
            anchors.append(widthAnchor.constraint(equalTo: width, multiplier: widthMultiplier))
        }

        if let height = height {
            anchors.append(heightAnchor.constraint(equalTo: height, multiplier: heightMultiplier))
        }

        NSLayoutConstraint.activate(anchors)

        return self
    }

    @discardableResult
    public func fillSuperview(top: CGFloat = 0,
                              bottom: CGFloat = 0,
                              leading: CGFloat = 0,
                              trailing: CGFloat = 0) -> UIView {
        fillSuperviewWidth(leading: leading, trailing: trailing)
        fillSuperviewHeight(top: top, bottom: bottom)

        return self
    }

    @discardableResult
    public func fillSuperviewWidth(leading: CGFloat = 0, trailing: CGFloat = 0) -> UIView {
        translatesAutoresizingMaskIntoConstraints = false

        if let superview = superview {
            NSLayoutConstraint.activate([
                leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: leading),
                trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -trailing)
            ])
        }

        return self
    }

    @discardableResult
    public func fillSuperviewHeight(top: CGFloat = 0, bottom: CGFloat = 0) -> UIView {
        translatesAutoresizingMaskIntoConstraints = false

        if let superview = superview {
            NSLayoutConstraint.activate([
                topAnchor.constraint(equalTo: superview.topAnchor, constant: top),
                bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -bottom)
            ])
        }

        return self
    }

    @discardableResult
    public func anchorCenterXToSuperview(constant: CGFloat = 0) -> UIView {
        translatesAutoresizingMaskIntoConstraints = false

        if let anchor = superview?.centerXAnchor {
            centerXAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
        }

        return self
    }

    @discardableResult
    public func anchorCenterYToSuperview(constant: CGFloat = 0) -> UIView {
        translatesAutoresizingMaskIntoConstraints = false

        if let anchor = superview?.centerYAnchor {
            centerYAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
        }

        return self
    }

    @discardableResult
    public func anchorCenterToSuperview() -> UIView {
        anchorCenterXToSuperview()
        anchorCenterYToSuperview()

        return self
    }

    @discardableResult
    public func anchorCenterX(to view: UIView, constant: CGFloat = 0) -> UIView {
        translatesAutoresizingMaskIntoConstraints = false

        centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: constant).isActive = true

        return self
    }

    @discardableResult
    public func anchorCenterY(to view: UIView, constant: CGFloat = 0) -> UIView {
        translatesAutoresizingMaskIntoConstraints = false

        centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: constant).isActive = true

        return self
    }
}
