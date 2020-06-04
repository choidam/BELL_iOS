//
//  MapContentViewController.swift
//  BELL
//
//  Created by 최은지 on 04/06/2020.
//  Copyright © 2020 최은지. All rights reserved.
//

import UIKit

class MapContentViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var aqiTableView: UITableView!
    
    let data = [
        "data1",
        "data2",
        "data3"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        aqiTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        aqiTableView.delegate = self
        aqiTableView.dataSource = self
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = data[indexPath.row]
        
        return cell
    }


}
