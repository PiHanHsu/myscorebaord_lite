//
//  LoginViewController.swift
//  myscoreboard_lite
//
//  Created by PiHan on 2017/9/18.
//  Copyright © 2017年 PiHan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var loginButton: CapsuleButton!
    
    var user: Player?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addGradient()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        emailTextField.text = ""
        passwordTextField.text = ""
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        
        let reachability = Reachability()!
        reachability.whenReachable = { reachability in
            if reachability.connection == .wifi {
                print("Reachable via WiFi")
            } else {
                print("Reachable via Cellular")
            }
        }
    
        reachability.whenUnreachable = { _ in
            let alertController = UIAlertController(title: "離線中", message: "請確認帳網路是否連線", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .cancel, handler: { _ in
                self.activityIndicator.stopAnimating()
            })
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
        
        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
        
        activityIndicator.startAnimating()
        loginButton.isEnabled = false
        
        let email = emailTextField.text!.trim()
        let password = passwordTextField.text!.trim()
        
        let params = ["email" : email,
                      "password" : password]
        Alamofire.request("https://product.myscoreboardapp.com/api/v1/login", method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).validate().responseJSON{response in
            
            if response.result.isSuccess{
                
                let player = JSON(response.result.value!)
                
                if let user_id = player["user_id"].int {
                    if let auth_token = player["auth_token"].string{
                        self.getTeamList(user_id, token: auth_token)
                        DataSource.sharedInstance.auth_token = auth_token
                    }
                }
            }else{
                let alertController = UIAlertController(title: "登入失敗", message: "請確認帳號密碼是否正確", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .cancel, handler: { _ in
                    self.activityIndicator.stopAnimating()
                })
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
                
            }
            self.loginButton.isEnabled = true
        }
    }
    
    func getTeamList(_ userID: Int, token: String){
        
        let params = ["auth_token" : token,
                      "user_id" : userID] as [String : Any]
        Alamofire.request("https://product.myscoreboardapp.com/api/v1/teams", method: .get, parameters: params, encoding: JSONEncoding.default, headers: nil).validate().responseJSON{response in
            if response.result.isSuccess{
                
                let data = JSON(response.result.value!)
                
                for team in data["results"].arrayValue {
                    DataSource.sharedInstance.teams.append(Team(data: team))
                }
                self.activityIndicator.stopAnimating()
                self.performSegue(withIdentifier: "GoToTeamsPage", sender: self)
            }else{
                
                print("load team data error")
            }
            self.loginButton.isEnabled = true
        }
    }
    
}
