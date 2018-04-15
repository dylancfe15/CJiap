//
//  teamInfoMembersViewController.swift
//  CJiap
//
//  Created by Difeng Chen on 1/7/18.
//  Copyright © 2018 Difeng Chen. All rights reserved.
//

import UIKit
import AVFoundation
class teamInfoMembersViewController: UIViewController,AVCaptureMetadataOutputObjectsDelegate {
    var video = AVCaptureVideoPreviewLayer()
    let session = AVCaptureSession()
    var userID = String()
    var teamID = String()
    override func viewDidLoad() {
        super.viewDidLoad()
        //create session
        
    }
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        if(metadataObjects != nil && metadataObjects.count != 0){
            if let object = metadataObjects[0] as? AVMetadataMachineReadableCodeObject{
                if object.type == AVMetadataObject.ObjectType.qr{
                    userID = object.stringValue!
                    performSegue(withIdentifier: "scanSegue", sender: Any?.self)
                }
            }
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.destination is teamInfoMembersScannedViewController){
            let TIMS = segue.destination as! teamInfoMembersScannedViewController
            TIMS.userID = userID
            TIMS.teamID = teamID
        }
    }
    
    @IBAction func addAMember(_ sender: Any) {
        //define capture device
        let captureDevice = AVCaptureDevice.default(for: AVMediaType.video)
        do{
            let input = try AVCaptureDeviceInput(device: captureDevice!)
            session.addInput(input)
        }catch{
            print("Error.")
        }
        let output = AVCaptureMetadataOutput()
        session.addOutput(output)
        output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        output.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]
        video = AVCaptureVideoPreviewLayer(session: session)
        video.frame = view.layer.bounds
        view.layer.addSublayer(video)
        session.startRunning()
    }
    

}
