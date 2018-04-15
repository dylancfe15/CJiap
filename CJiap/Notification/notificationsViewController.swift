//
//  notificationsViewController.swift
//  
//
//  Created by Difeng Chen on 1/9/18.
//

import UIKit
import FirebaseDatabase
import Firebase
class notificationsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
   
    @IBOutlet weak var noticeSegment: UISegmentedControl!
    @IBOutlet weak var requestTable: UITableView!
    let dateFormatter = DateFormatter()
    var ref: DatabaseReference!
    var handle: DatabaseHandle!
    var user = Auth.auth().currentUser
    struct requestStruct {
        var teamNameRequest = String()
        var timeStampRequest = Double()
        var senderRequest = String()
        var statueRequest = String()
        var typeRequest = String()
        var teamID = String()
    }
    var requestStructArray = [requestStruct]()
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        dateFormatter.timeStyle = DateFormatter.Style.short
        ref = Database.database().reference()
        handle = ref.child("Users").child((user?.uid)!).child("Notifications").child("Team Invitations").observe(.childAdded, with: { (snapshot) in
            var tempRequestStruct = requestStruct()
            tempRequestStruct.teamID = snapshot.key 
            tempRequestStruct.timeStampRequest = snapshot.childSnapshot(forPath: "Date").value as! Double
            tempRequestStruct.senderRequest = snapshot.childSnapshot(forPath: "Sender").value as! String
            tempRequestStruct.statueRequest = snapshot.childSnapshot(forPath: "Statue").value as! String
            tempRequestStruct.teamNameRequest = snapshot.childSnapshot(forPath: "Team Name").value as! String
            tempRequestStruct.typeRequest = "Invitation"
            self.requestStructArray.append(tempRequestStruct)
            self.requestTable.reloadData()
        })
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    /*
    @IBAction func noticeSegment(_ sender: Any) {
        if(noticeSegment.selectedSegmentIndex == 0){
            notificationTable.isHidden = false
            requestTable.isHidden = true
        }else{
            notificationTable.isHidden = true
            requestTable.isHidden = false
        }
    }
    */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return requestStructArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let invitationCell = tableView.dequeueReusableCell(withIdentifier: "invitationCell", for: indexPath) as! invitationsTableViewCell
        invitationCell.statueLabel.text = requestStructArray[indexPath.row].statueRequest
        invitationCell.senderLabel.text = requestStructArray[indexPath.row].senderRequest + " invited you to join this team."
        invitationCell.teamID = requestStructArray[indexPath.row].teamID
        invitationCell.teamNameLabel.text = requestStructArray[indexPath.row].teamNameRequest
        invitationCell.timeLabel.text = dateFormatter.string(from: NSDate(timeIntervalSince1970:requestStructArray[indexPath.row].timeStampRequest/1000) as Date)
        invitationCell.cellBackground.layer.cornerRadius = 5
        invitationCell.cellBackground.layer.masksToBounds = true
        
        return invitationCell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 210
    }

}
