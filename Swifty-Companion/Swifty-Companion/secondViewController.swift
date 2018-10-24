//
//  secondViewController.swift
//  Swifty-Companion
//
//  Created by Asahel RANGARIRA on 2018/10/24.
//  Copyright © 2018 Khomotjo. All rights reserved.
//

import UIKit
import JSONParserSwift
import SwiftyJSON

class secondViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    
    /*  Stuct Properties */
    var baseResbonse = [BaseResponse]()
    var cursusUsers = [Cursus_users]()
    var skills = [Skills]()
    var projectUsers = [Projects_users]()
    var project = [Project]()
    
    /* skills table properties*/
    
    @IBOutlet weak var skillsTableView: UITableView!
    @IBOutlet weak var projectTableView: UITableView!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.skills.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = skillsTableView.dequeueReusableCell(withIdentifier: "skills") as! SkillsTableViewCell
                cell.skill = self.skills[indexPath.row]
                print(self.skills.count)
                return cell
    }
}
