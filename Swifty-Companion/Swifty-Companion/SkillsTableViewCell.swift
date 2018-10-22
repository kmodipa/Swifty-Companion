//
//  SkillsTableViewCell.swift
//  Swifty-Companion
//
//  Created by Asahel RANGARIRA on 2018/10/22.
//  Copyright © 2018 Khomotjo. All rights reserved.
//

import UIKit

class SkillsTableViewCell: UITableViewCell {

    @IBOutlet weak var skillsLabel: UILabel!
    @IBOutlet weak var skillsPercentageLabel: UILabel!
    @IBOutlet weak var skillsProgressBar: UIProgressView!
    
    
    var skill : (String, String, Float)? {
            didSet {
            if let s = skill{
                skillsLabel?.text = s.0
                skillsPercentageLabel?.text = s.1
                skillsProgressBar?.progress = s.2
            }
        }
    }
}
