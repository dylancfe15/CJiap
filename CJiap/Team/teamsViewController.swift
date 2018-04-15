//
//  teamsViewController.swift
//  CJiap
//
//  Created by Difeng Chen on 1/5/18.
//  Copyright © 2018 Difeng Chen. All rights reserved.
//

import UIKit
import FirebaseDatabase
import Firebase
class teamsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    let user = Auth.auth().currentUser
    var ref: DatabaseReference!
    var handle:DatabaseHandle!
    var selectedTeamID = String()
    var teamIDsArray = [String]()
    var teamNamesArray = [String]()
    var teamMembersArray = [String]()
    @IBOutlet weak var teamTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        //find teamid
        handle = ref.child("Users").child((user?.uid)!).child("Teams").observe(.childAdded, with: { (snapshot) in
            self.teamIDsArray.append(snapshot.value as! String)
        })
        
        //find team info
        handle = ref.child("Teams").observe(.childAdded, with: { (snapshot) in
            for result in self.teamIDsArray{
                if(result == snapshot.key){
                    self.teamNamesArray.append(snapshot.childSnapshot(forPath: "Team Name").value as! String)
                    self.teamTable.reloadData()
                }
            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teamIDsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "teamCell", for: indexPath) as! teamTableViewCell
        cell.teamNameLabel.text = teamNamesArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedTeamID = String(teamIDsArray[indexPath.row])
        performSegue(withIdentifier: "teamIDSegue", sender: Any?.self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.destination is teamInfoViewController){
            let TI = segue.destination as! teamInfoViewController
            TI.teamID = selectedTeamID
        }
    }
    
}
