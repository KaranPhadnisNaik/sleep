//
//  LoginViewController.swift
//  Wake Up Bitch
//
//  Created by Yaacov Tarko on 4/1/17.
//  Copyright © 2017 Kevin Kou. All rights reserved.
//

import UIKit


class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var loginUsername: UITextField!
    @IBOutlet weak var loginPassword: UITextField!
    
    @IBAction func loginPressed(_ sender: Any) {
        let endpoint : String = "http://li260-173.members.linode.com/wakeup/api/login?user=" + loginUsername.text! + "&password=" + loginPassword.text!
        print(endpoint)
        
        let url = URL(string : endpoint)
        let urlRequest = URLRequest(url: url!)
        let urlSession = URLSession.shared     //???
        
        let task = urlSession.dataTask(with: urlRequest) { data, response, error in
            // do stuff with response, data & error here
            guard error == nil else {
                print(error!)
                return
            }
            
            // make sure we got data
            guard let responseData = data else {
                print("Error: did not receive data")
                return
            }
            
            // parse the result as JSON, since that's what the API provides
            do {
                print(data!)
                guard let todo = try JSONSerialization.jsonObject(with: responseData, options: [])
                    as? [String: Any] else {
                        print("error trying to convert data to JSON")
                        return
                }
                // now we have the todo
                // let's just print it to prove we can access it
                print("The todo is: " + todo.description)
                
                // the todo object is a dictionary
                // so we just access the title using the "title" key
                // so check for a title and print it if we have one
                guard let todoTitle = todo["password"] as? String else {
                    print("login failed")
                    return
                }
                //otherwise, go to Kevin's screen that lets you make alarms and settings and stuff 
                print("The password is: " + todoTitle)
            } catch  {
                print("error trying to convert data to JSON")
                return
            }
        }
        task.resume()
        
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
