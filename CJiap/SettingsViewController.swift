//
//  SettingsViewController.swift
//  CJiap
//
//  Created by Difeng Chen on 1/1/18.
//  Copyright © 2018 Difeng Chen. All rights reserved.
//

import UIKit
import Firebase
class SettingsViewController: UIViewController {

    @IBOutlet weak var phoneNumTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    let user = Auth.auth().currentUser
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.placeholder = user?.email
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func setEmail(_ sender: Any) {
        user?.updateEmail(to: emailTextField.text!, completion: { (error) in
            if error != nil{
                print(error ?? "")
            }
        })
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
