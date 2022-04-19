//
//  ResultLabel.swift
//  Calculator
//
//  Created by Екатерина Неделько on 19.04.22.
//

import UIKit

class ResultLabel: UILabel {
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        self.adjustsFontSizeToFitWidth = true
        self.minimumScaleFactor = 0.01
    }
}
