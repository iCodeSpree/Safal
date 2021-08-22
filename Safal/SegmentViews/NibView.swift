//
//  NibView.swift
//  Safal
//
//  Created by Shreya Jhala on 8/21/21.
//

import UIKit

class NibView: UIView {
    
    var view: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        //commonInit()
    }
    
    private func commonInit() {
        //view = loadNib()
        // use bounds not frame or it'll be offset
        view.frame = bounds
        // Adding custom subview on top of our view
        addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
    }
    /*
     func loadNib() -> UIView? {
         let bundle = Bundle(for: type(of: self))
         let nibName = type(of: self).description().components(separatedBy: ".").last!
         let nib = UINib(nibName: nibName, bundle: bundle)
         return nib.instantiate(withOwner: self, options: nil).first as? UIView
     }
     */
    
}
