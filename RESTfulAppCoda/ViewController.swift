//
//  ViewController.swift
//  RESTfulAppCoda
//
//  Created by Michael Evans on 1/12/21.
//  Copyright © 2021 MREink. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let rest = RestManager()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        getUsersList()
    }
    
    func getUsersList() {
        guard let url = URL(string: "https://reqres.in/api/users") else { return }
        
        rest.makeRequest(toURL: url, withHttpMethod: .get) { (results) in
            if let data = results.data {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                guard let userData = try? decoder.decode(UserData.self, from: data) else { return }
                print(userData.description)
            }
            
            print("\n\nResponse HTTP Headers:\n")
            
            if let response = results.response {
                for (key, value) in response.headers.allValues() {
                    print(key, value)
                }
            }
        }
    }


}

