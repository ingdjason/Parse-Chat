//
//  ChatViewController.swift
//  Parse Chat
//
//  Created by Djason  Sylvaince on 10/11/18.
//  Copyright © 2018 Sandyna Sandaire. All rights reserved.
//

import UIKit
import Parse

class ChatViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var msgField: UITextField!
    let currentusr = PFUser.current()!
    var msg = [PFObject]()
    var refreshControl: UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 120
        tableView.rowHeight = 120 //UITableViewAutomaticDimension
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(ChatViewController.didPullToRefresh(_:)), for: .valueChanged)
        loadData()
        tableView.insertSubview(refreshControl, at: 0)
        self.tableView.reloadData()
        
        Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(self.loadData), userInfo: nil, repeats: true)
    }

    @objc func didPullToRefresh(_ refreshControl: UIRefreshControl)
    {
        loadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("TOTAL MSG : \(msg.count)")
        return msg.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatCell") as! ChatCell
        
        let chat = msg[indexPath.row]
        if let user = chat["user"] as? PFUser {
            // User found! update username label with username
            if(currentusr.username == user.username!){
                cell.userLbl.backgroundColor = UIColor.cyan
                cell.userLbl.text = user.username
            }else{
                cell.userLbl.backgroundColor = UIColor.brown
                cell.userLbl.text = user.username
            }
            
        }else{
            cell.userLbl.text = "🤖"
        }
        cell.messageLbl.text = (chat["text"] as! String)
        
        return cell
    }
    
    @objc func loadData(){
        // construct query
        let query = PFQuery(className: "Message")
        query.addDescendingOrder("createdAt")
        query.includeKey("user")
        
        // fetch data asynchronously
        query.findObjectsInBackground { (posts: [PFObject]?, error: Error?) in
            if let posts = posts {
                // do something with the array of object returned by the call
                
                for message in posts{
                    if (message["text"] != nil)
                    {
                        print(message["text"]!)
                    }else{
                        print("no text")
                    }
                }
                self.msg = posts
                self.tableView.reloadData()
                self.refreshControl.endRefreshing()
            } else {
                print(error?.localizedDescription)
            }
        }
        self.tableView.reloadData()
    }
    
    @IBAction func sendMsg(_ sender: Any) {
        let chatMessage = PFObject(className: "Message")
        let currentuser = PFUser.current()!
        chatMessage["text"] = msgField.text ?? ""
        chatMessage["user"] = currentuser
        
        chatMessage.saveInBackground { (success, error) in
            if success {
                print("The message was saved!")
                self.msgField.text = ""
            } else if let error = error {
                print("Problem saving message: \(error.localizedDescription)")
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
