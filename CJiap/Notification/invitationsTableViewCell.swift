//
//  invitationsTableViewCell.swift
//  CJiap
//
//  Created by Difeng Chen on 1/17/18.
//  Copyright © 2018 Difeng Chen. All rights reserved.
//

import UIKit

import Firebase
class invitationsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cellBackground: UIView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var senderLabel: UILabel!
    @IBOutlet weak var statueLabel: UILabel!
    @IBOutlet weak var teamNameLabel: UILabel!
    var teamID = String()
    let user = Auth.auth().currentUser
    var ref = Database.database().reference()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func reject(_ sender: Any) {
        ref.child("Users").child((user?.uid)!).child("Notifications").child("Team Invitations").child(teamID).child("Statue").setValue("Rejected")
    }
    @IBAction func accept(_ sender: Any) {
        
        ref.child("Teams").observe(DataEventType.childAdded) { (snapshot) in
            if(snapshot.hasChild(self.teamID)){
                self.ref.child("Users").child((self.user?.uid)!).child("Notifications").child("Team Invitations").child(self.teamID).child("Statue").setValue("Accepted")
            }
        }
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
