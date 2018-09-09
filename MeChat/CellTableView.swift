//
//  CellTableView.swift
//  MeChat
//
//  Created by Pedro Antonio Vazquez Rodriguez on 09/09/18.
//  Copyright © 2018 Abner Castro. All rights reserved.
//

import UIKit

class CellTableView: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var percentageLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setCell(tone: Tone) {
        titleLabel.text = tone.toneName
        percentageLabel.text = "\(tone.score! * 100)%"
        progressView.progress = Float(tone.score!)
    }
    
}
