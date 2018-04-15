//
//  teamInfoMembersScannedViewController.swift
//  CJiap
//
//  Created by Difeng Chen on 1/7/18.
//  Copyright © 2018 Difeng Chen. All rights reserved.
//

import UIKit
import FirebaseDatabase
import Firebase
class teamInfoMembersScannedViewController: UIViewController {
    var userID = String()
    var teamID = String()
    var ref : DatabaseReference!
    var handle = DatabaseHandle()
    var numOfInvitations = 1
    var teamName = String()
    var user = Auth.auth().currentUser
    @IBOutlet weak var userEmail: UILabel!
    @IBOutlet weak var userIDLabel: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userProfileImage: UIImageView!
    @IBOutlet weak var message: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        userIDLabel.text = userID
        handle = ref.child("Users").child(userID).child("Notices").child("Team Invitations").observe(DataEventType.childAdded, with: { (snapshot) in
            self.numOfInvitations += 1
        })
        handle = ref.child("Users").child(userID).child("User Name").observe(.value, with: { (snapshot) in
            self.userName.text = snapshot.value as? String
        })
        handle = ref.child("Users").child(userID).child("Email").observe(.value, with: { (snapshot) in
            self.userEmail.text = snapshot.value as? String
        })
        handle = ref.child("Users").child(userID).child("PhotoURL").observe(.value, with: { (snapshot) in
            let photoURL = URL(string: snapshot.value as! String)
            if let data = try? Data(contentsOf: photoURL!)
            {
                self.userProfileImage.image = UIImage(data: data)!
            }
            self.userProfileImage.layer.cornerRadius = self.userProfileImage.frame.width/2
            self.userProfileImage.layer.masksToBounds = true
            
        })
        handle = ref.child("Teams").child(teamID).child("Team Name").observe(.value, with: { (snapshot) in
            self.teamName = (snapshot.value as? String)!
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func request(_ sender: Any) {
        ref.child("Users").child(userID).child("Notifications").child("Team Invitations").child(teamID).child("Statue").setValue("Pending")
        ref.child("Users").child(userID).child("Notifications").child("Team Invitations").child(teamID).child("Date").setValue(ServerValue.timestamp())
        ref.child("Users").child(userID).child("Notifications").child("Team Invitations").child(teamID).child("Team Name").setValue(teamName)
        ref.child("Users").child(userID).child("Notifications").child("Team Invitations").child(teamID).child("Sender").setValue(user?.displayName)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.destination is teamInfoMembersViewController){
            let TIM = segue.destination as! teamInfoMembersViewController
            TIM.teamID = teamID
        }
    }

}
