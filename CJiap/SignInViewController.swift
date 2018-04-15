//
//  SignInViewController.swift
//  CJiap
//
//  Created by Difeng Chen on 12/30/17.
//  Copyright © 2017 Difeng Chen. All rights reserved.
//

import UIKit
import GoogleSignIn
import Firebase
import FBSDKLoginKit

class SignInViewController: UIViewController,FBSDKLoginButtonDelegate,GIDSignInUIDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        let FBLoginButton = FBSDKLoginButton()
        FBLoginButton.frame = CGRect(x: 16, y: 50, width: view.frame.width-32, height: 50)
        view.addSubview(FBLoginButton)
        FBLoginButton.delegate = self
        FBLoginButton.readPermissions = ["email", "public_profile"]
        
        let GoogleLoginButton = GIDSignInButton()
        GoogleLoginButton.frame = CGRect(x: 16, y: 116, width: view.frame.width-32, height: 50)
        
        view.addSubview(FBLoginButton)
        view.addSubview(GoogleLoginButton)
        
        GIDSignIn.sharedInstance().uiDelegate = self
        let user = Auth.auth().currentUser
        if(user != nil){
            performSegue(withIdentifier: "home", sender: nil)
        }
    }

    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("Did log out of FB!")
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if error != nil{
            print(error)
            return
        }
        let accessToken = FBSDKAccessToken.current()
        guard let accessTokenString = accessToken?.tokenString else{return}
        
        let credentials = FacebookAuthProvider.credential(withAccessToken:accessTokenString)
        
        Auth.auth().signIn(with: credentials) { (user, error) in
            if error != nil{
                print("Something went wrong with our FB user:",error ?? "")
                return
            }
            print("Successfully logged in with our user:",user ?? "")
           self.performSegue(withIdentifier: "home", sender: nil)
        }
        FBSDKGraphRequest(graphPath: "/me", parameters: ["fields":"id, name, email"]).start { (connetion, result, err) in
            if err != nil{
                print("Failed to start graph request:", err ?? "")
                return
            }
            print(result ?? "")
        }
    }
    
    func sign(inWillDispatch signIn: GIDSignIn!, error: Error!) {
        self.performSegue(withIdentifier: "home", sender: nil)
    }
}
