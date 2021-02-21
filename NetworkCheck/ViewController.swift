//
//  ViewController.swift
//  NetworkCheck
//
//  Created by Andrew Kolbasov on 19.02.2021.
//

import UIKit
import Alamofire
import SwiftyJSON

struct Human: Decodable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

class ViewController: UIViewController {
    
    let jsonUrl = "https://jsonplaceholder.typicode.com/posts/1"
    
    var humans = [Human]()

    let textLabel:UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 0
        lbl.backgroundColor = .green
        lbl.text = "follow"
        return lbl
    }()
    
    let netButton:UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = .orange
        btn.setTitle("Go for it", for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
        btn.addTarget(self, action: #selector(goForItButton), for: .touchUpInside)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemIndigo
        view.addSubview(textLabel)
        view.addSubview(netButton)
    }
    
    @objc
    func goForItButton(){
//        requestWithAlamofire(url: jsonUrl)
        fetchHuman()
    }
    
//REQUEST USING ALAMOFIRE + SWIFTY JSON
    func requestWithAlamofire(url: String){
        AF.request(url, method: .get).responseJSON { response in
            if let whatIGot = response.value {
                let myJSON = JSON(whatIGot)
                self.textLabel.text = myJSON["body"].stringValue
            } else if (response.error != nil) {
                print("Alamofire error: \(String(describing: response.error))")
            }
        }
    }
    
//REQUEST USING URLSESSION
    fileprivate func fetchHuman(){
        Service.shared.getRequestWithURLSession { (result) in
            switch result {
            case .failure(let error):
                print("Error with fetching: \(error)")
            case .success(let human):
                print("U've got: \(human[0].title)")
                self.humans = human
                self.textLabel.text = human.first?.title
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        textLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        textLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15).isActive = true
        textLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15).isActive = true
        
        netButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100).isActive = true
        netButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 25).isActive = true
        netButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -25).isActive = true
        netButton.heightAnchor.constraint(equalToConstant: 150).isActive = true
    }


}

