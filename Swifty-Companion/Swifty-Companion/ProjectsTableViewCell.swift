//
//  ProjectsTableViewCell.swift
//  Swifty-Companion
//
//  Created by Asahel RANGARIRA on 2018/10/22.
//  Copyright © 2018 Khomotjo. All rights reserved.
//

import UIKit

class ProjectsTableViewCell: UITableViewCell {

    @IBOutlet weak var projectLabel: UILabel!
    
    @IBOutlet weak var projectPercentageLabel: UILabel!
    
    var project : (Projects_users)?
    {
        didSet{
            if let s = project {
                projectLabel.text = s.project?.name
                projectPercentageLabel.text = String(s.final_mark)
            }
        }
    }
}
