//
//  ViewController.swift
//  Swifty-Companion
//
//  Created by Khomotjo MODIPA on 2018/10/17.
//  Copyright © 2018 Khomotjo. All rights reserved.
//

import UIKit
import JSONParserSwift
import SwiftyJSON

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    /*  Stuct Properties */
    var baseResbonse = [BaseResponse]()
    var cursusUsers = [Cursus_users]()
    var skills = [Skills]()
    var projectUsers = [Projects_users]()
    var project = [Project]()
    
    /* UI Properties */
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var walletLabel: UILabel!
    @IBOutlet weak var correctionLabel: UILabel!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
   /* skills table properties*/
    
    @IBOutlet weak var skillsTableView: UITableView!
    @IBOutlet weak var projectTableView: UITableView!
    
    
    
    @IBOutlet weak var imageView: UIImageView!
    
    var user: String? /* Info comes from the textField specified in the EntrViewController */
    
    var deToken = ""
    var topicsBackup: [Dictionary<String,Any>]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let UID = "ce3639778c7e09492c14afd96f1351585b88a7b533776bf487f45483c789a9be"
        let SECRET = "baa1b092885602618b1ff23cfcb97344c3179c60973aad7a2af9a4f62f0bc9f4"
        let BEARER = ((UID + ":" + SECRET).data(using: String.Encoding.utf8, allowLossyConversion: true))!.base64EncodedString(options: Data.Base64EncodingOptions(rawValue: 0))
        
        guard let url = URL(string: "https://api.intra.42.fr/oauth/token") else {return}
        let session = URLSession.shared
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Basic " + BEARER, forHTTPHeaderField: "Authorization")
        request.setValue("application/x-www-form-urlencoded;charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.httpBody = "grant_type=client_credentials".data(using: String.Encoding.utf8)
        
        let task = session.dataTask(with: request as URLRequest, completionHandler: {
            (data, response, error) in
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
                    if let token = json["access_token"]
                    {
                        self.deToken = token as! String
                        
                        /* Call the below funcs */
                        _ = self.getUserInfo()
                    }
                } catch {
                    print(error)
                }
            }
        })
        
        task.resume()
    }
    
    /*  Getting the user info */
    func getUserInfo() {
        print("Started connection")

        let authEndPoint: String = "https://api.intra.42.fr/v2/users/\(user!)"
        //        print(user!)
        let url = URL(string: authEndPoint)
        var request = URLRequest(url: url!)
        request.setValue("Bearer \(self.deToken)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
        let session = URLSession.shared
        
        let requestGET = session.dataTask(with: request) { (data, response, error) in
            if let data = data {
                do {

                    let json = try JSON(data: data)
                    
//                    print(json)
                    let skills = json["cursus_users"][0]["skills"]
                    let projectUsers = json["projects_users"]
                    let cursusUsers = json["cursus_users"]

                    let image = json["image_url"].stringValue
                    print(image)
//                    print(json[].string)
                    

                    /* Getting Cursus_users */
                    for element in cursusUsers.arrayValue {
                        self.cursusUsers.append(Cursus_users(element))
                    }
                    
                    /* Getting Project_users */
                    for element in projectUsers.arrayValue {
                        self.projectUsers.append(Projects_users(element))
                    }
                    
                    /* Getting the BaseResponds */
                    self.baseResbonse.append(BaseResponse(json))

//                    print(self.baseResbonse)

                    /* Getting Skills */
                    for element in skills.arrayValue {
                        self.skills.append(Skills(element))
                    }
                  
                    DispatchQueue.main.async {
                        self.userNameLabel.text = self.baseResbonse[0].login
                        self.phoneLabel.text = String(self.baseResbonse[0].phone)
                        self.walletLabel.text = String(self.baseResbonse[0].wallet)
                        self.correctionLabel.text = String(self.baseResbonse[0].correction_point)
                        self.levelLabel.text = "Level: \(String(self.cursusUsers[0].level))"
                    }
                    print("Skills: \(self.skills[1].name)")
                    
                    _ = self.displayUserInfo(baseResbonse: self.baseResbonse, cursusUsers: self.cursusUsers, skills: self.skills, projectUsers: self.projectUsers, project: self.project)
                    
                } catch {
                    print(error)
                }
            }
            else {
                print("Data is null")
            }    
        }
        requestGET.resume()
        print("End token")
    }
    
    /* Display user info */
    func displayUserInfo(baseResbonse: [BaseResponse], cursusUsers: [Cursus_users], skills: [Skills], projectUsers: [Projects_users], project: [Project]) {
        
        DispatchQueue.main.async {
            self.userNameLabel.text = self.baseResbonse[0].login
            self.phoneLabel.text = "0\(String(self.baseResbonse[0].phone))"
            self.walletLabel.text = String(self.baseResbonse[0].wallet)
            self.correctionLabel.text = String(self.baseResbonse[0].correction_point)
            self.levelLabel.text = "Level: \(String(Int(self.cursusUsers[0].level))) - \(Float((self.cursusUsers[0].level)) - Float(Int(self.cursusUsers[0].level)))%"
            self.progressBar.progress = Float((self.cursusUsers[0].level)) - Float(Int(self.cursusUsers[0].level))
            
            if let url = URL(string: self.baseResbonse[0].image_url)
            {
                self.imageView.layer.borderWidth = 2
                self.imageView.layer.borderColor = UIColor.white.cgColor
                self.imageView.layer.cornerRadius = 70
                self.imageView.clipsToBounds = true
                self.downloadImage(from: url)
                
            }
        }
    }
    
    /* Count number of content to display on the table */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == skillsTableView {
            return (self.skills.count)
        }
        else if tableView == projectTableView {
            return (self.projectUsers.count)
        }
        
        return 0
    }
    
    /* Working with the relevant table and cell */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == skillsTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "skills") as! SkillsTableViewCell
            cell.skill = self.skills[indexPath.row]
            return cell
        }
        else if tableView == projectTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "projects") as! ProjectsTableViewCell
            cell.project = self.projectUsers[indexPath.row]
            return cell
        }
        
        return UITableViewCell()
    }
    
    /* Task to fetch the image */
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    /* Download image form given url */
    func downloadImage(from url: URL)
    {
        print("Download Started")
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            DispatchQueue.main.async() {
                self.imageView.image = UIImage(data: data)
            }
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

