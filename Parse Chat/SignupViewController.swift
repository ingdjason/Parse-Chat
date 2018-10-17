//
//  SignupViewController.swift
//  Parse Chat
//
//  Created by Djason  Sylvaince on 10/11/18.
//  Copyright © 2018 Sandyna Sandaire. All rights reserved.
//

import UIKit
import Parse


class SignupViewController: UIViewController {
    @IBOutlet weak var emailLabel: UITextField!
    @IBOutlet weak var usernameLabel: UITextField!
    @IBOutlet weak var passwordLabel: UITextField!
    @IBOutlet weak var confirmpassLabel: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
         self.activityIndicator.stopAnimating()
    }
    
    @IBAction func signup(_ sender: Any) {
        self.activityIndicator.startAnimating()
        if(!(emailLabel.text?.isEmpty)! && !(usernameLabel.text?.isEmpty)! && !(passwordLabel.text?.isEmpty)! && !(confirmpassLabel.text?.isEmpty)!){
            if(passwordLabel.text! == confirmpassLabel.text!){
                // initialize a user object
                let newUser = PFUser()
                // set user properties
                newUser.username = usernameLabel.text
                newUser.email = emailLabel.text
                newUser.password = passwordLabel.text
                
                // call sign up function on the object
                newUser.signUpInBackground { (success: Bool, error: Error?) in
                    self.activityIndicator.stopAnimating()
                    if let error = error {
                        print(error.localizedDescription)
                        
                        let alertController = UIAlertController(title: "ERROR", message: "Try again later...\(error.localizedDescription)", preferredStyle: .alert)
                        let cancelAction = UIAlertAction(title: "Ok", style: .cancel) { (action) in
                            // handle cancel response here. Doing nothing will dismiss the view.
                        }
                        // add the cancel action to the alertController
                        alertController.addAction(cancelAction)
                        
                        self.present(alertController, animated: true) {
                            // optional code for what happens after the alert controller has finished presenting
                        }
                    } else {
                        print("User Registered successfully")
                        // manually segue to logged in view
                        let alertController = UIAlertController(title: "SUCCESS", message: "User Registered successfully", preferredStyle: .alert)
                        let cancelAction = UIAlertAction(title: "Ok", style: .cancel) { (action) in
                            // handle cancel response here. Doing nothing will dismiss the view.
                            self.dismiss(animated: false, completion: nil)
                        }
                        // add the cancel action to the alertController
                        alertController.addAction(cancelAction)
                        
                        self.present(alertController, animated: true) {
                            // optional code for what happens after the alert controller has finished presenting
                        }
                    }
                }
            }else{
                self.activityIndicator.stopAnimating()
                let alertController = UIAlertController(title: "PASSWORD", message: "Password different to Confirm password...", preferredStyle: .alert)
                let cancelAction = UIAlertAction(title: "Ok", style: .cancel) { (action) in
                    // handle cancel response here. Doing nothing will dismiss the view.
                }
                // add the cancel action to the alertController
                alertController.addAction(cancelAction)
                
                self.present(alertController, animated: true) {
                    // optional code for what happens after the alert controller has finished presenting
                }
            }
        }else{
            self.activityIndicator.stopAnimating()
            let alertController = UIAlertController(title: "EMPTY FIELD", message: "One or more fields empty...", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "Ok", style: .cancel) { (action) in
                // handle cancel response here. Doing nothing will dismiss the view.
            }
            // add the cancel action to the alertController
            alertController.addAction(cancelAction)
            
            self.present(alertController, animated: true) {
                // optional code for what happens after the alert controller has finished presenting
            }
        }
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
