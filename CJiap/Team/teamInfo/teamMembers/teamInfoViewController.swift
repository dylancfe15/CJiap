//
//  teamInfoViewController.swift
//  CJiap
//
//  Created by Difeng Chen on 1/7/18.
//  Copyright © 2018 Difeng Chen. All rights reserved.
//

import UIKit

class teamInfoViewController: UIViewController {
    var teamID = String()
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.destination is teamInfoMembersViewController){
            let TIM = segue.destination as! teamInfoMembersViewController
            TIM.teamID = teamID
        }
    }

}
