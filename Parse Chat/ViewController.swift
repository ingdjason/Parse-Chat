//
//  ViewController.swift
//  Parse Chat
//
//  Created by Djason  Sylvaince on 10/11/18.
//  Copyright © 2018 Sandyna Sandaire. All rights reserved.
//

import UIKit
import Parse


class ViewController: UIViewController {
    @IBOutlet weak var usernameLabel: UITextField!
    
    @IBOutlet weak var passwordLabel: UITextField!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // get the current user and assign it to "author" field. "author" field is now of Pointer type
       // post.author = PFUser.current()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginFunc(_ sender: Any, forEvent event: UIEvent) {
        activityIndicator.startAnimating()
        if(!(usernameLabel.text?.isEmpty)! && !(usernameLabel.text?.isEmpty)!){
            let username = usernameLabel.text ?? ""
            let password = passwordLabel.text ?? ""
            PFUser.logInWithUsername(inBackground: username, password: password) { (user: PFUser?, error: Error?) in
                if let error = error {
                    self.activityIndicator.stopAnimating()
                    print("User log in failed: \(error.localizedDescription)")
                    let alertController = UIAlertController(title: "ERROR", message: "User log in failed...", preferredStyle: .alert)
                    
                    let cancelAction = UIAlertAction(title: "Ok", style: .cancel) { (action) in
                        // handle cancel response here. Doing nothing will dismiss the view.
                    }
                    // add the cancel action to the alertController
                    alertController.addAction(cancelAction)
                    self.present(alertController, animated: true) {
                        // optional code for what happens after the alert controller has finished presenting
                    }
                } else {
                    self.activityIndicator.stopAnimating()
                    print("User logged in successfully")
                    // display view controller that needs to shown after successful login
                    self.performSegue(withIdentifier: "vcLogin", sender: nil)
                }
            }
        }else{
            self.activityIndicator.stopAnimating()
            let alertController = UIAlertController(title: "EMPTY FIELD", message: "Username or Password are empty...", preferredStyle: .alert)
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
    
    
    
   


}

