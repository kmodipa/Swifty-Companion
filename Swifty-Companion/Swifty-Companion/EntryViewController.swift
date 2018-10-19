//
//  EntryViewController.swift
//  Swifty-Companion
//
//  Created by Asahel RANGARIRA on 2018/10/19.
//  Copyright © 2018 Khomotjo. All rights reserved.
//

import UIKit

class EntryViewController: UIViewController {

    /* ViewController Properties */
    @IBOutlet weak var searchTextField: UITextField!
    
    @IBAction func searchButton(_ sender: UIButton) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "mySegue" {
            let destination = segue.destination as? ViewController
            destination?.user = searchTextField.text!
        }
    }
    

}
