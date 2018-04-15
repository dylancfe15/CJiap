//
//  CreateATeamViewController.swift
//  CJiap
//
//  Created by Difeng Chen on 1/1/18.
//  Copyright © 2018 Difeng Chen. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class CreateATeamViewController: UIViewController {

    @IBOutlet weak var TeamName: UITextField!
    var ref: DatabaseReference!
    var handle:DatabaseHandle!
    var teamsArray = [String]()
    var newTeamID = 1
    var numOfTeamUserHas = Int()
    var user = Auth.auth().currentUser
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        handle = ref.child("Teams").observe(.childAdded, with: { (snapshot) in
            print(snapshot.key)
            self.teamsArray.append(snapshot.key)
        })
        handle = ref.child("Users").child((user?.uid)!).child("Teams").observe(.childAdded, with: { (snapshot) in
            self.numOfTeamUserHas += 1
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func create(_ sender: Any) {
        print(teamsArray)
        for result in teamsArray{
            if(result == String(newTeamID)){
                newTeamID += 1
            }else{
                createATeam()
            }
        }
        if(newTeamID > teamsArray.count){
            createATeam()
        }
        TeamName.text = ""
        
    }
    
    //creat a team
    func createATeam(){
        ref.child("Teams").child(String(newTeamID)).child("Team Name").setValue(TeamName.text)
        ref.child("Teams").child(String(newTeamID)).child("Members").child("Manager").setValue(user?.uid)
        ref.child("Users").child((user?.uid)!).child("Teams").child(String(numOfTeamUserHas+1)).setValue(String(newTeamID))
    }
    
    
}
