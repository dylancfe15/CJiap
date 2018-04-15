//
//  HomeViewController.swift
//  CJiap
//
//  Created by Difeng Chen on 1/1/18.
//  Copyright © 2018 Difeng Chen. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
class HomeViewController: UIViewController {
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var UIDLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var userName: UILabel!
    var user = Auth.auth().currentUser
    var ref: DatabaseReference!
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        if (user != nil) {
            let name = user?.displayName
            let email = user?.email
            let uid = user?.uid
            let photoUrl = user?.photoURL
            let data = try? Data(contentsOf: photoUrl!)
            profileImage.image = UIImage(data: data!)!
            userName.text = name
            emailLabel.text = email
            UIDLabel.text = uid
        }
        
        ref.child("Users").child((user?.uid)!).child("User Name").setValue(user?.displayName)
        ref.child("Users").child((user?.uid)!).child("Email").setValue(user?.email)
        ref.child("Users").child((user?.uid)!).child("Phone Number").setValue(user?.phoneNumber)
        ref.child("Users").child((user?.uid)!).child("PhotoURL").setValue(user?.photoURL?.absoluteString)
        
        profileImage.layer.cornerRadius = profileImage.frame.width/2
        profileImage.layer.masksToBounds = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
