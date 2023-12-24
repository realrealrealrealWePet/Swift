//
//  CommunityViewController.swift
//  Wepet
//
//  Created by jaegu park on 1/10/23.
//

import UIKit

class CommunityViewController: UIViewController {
    
    @IBOutlet var CommuTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        CommuTableView.rowHeight = UITableView.automaticDimension
        CommuTableView.estimatedRowHeight = UITableView.automaticDimension

        CommuTableView.delegate = self
        CommuTableView.dataSource = self
        CommuTableView.layer.masksToBounds = true// any value you want
        CommuTableView.layer.shadowOpacity = 0.12// any value you want
        CommuTableView.layer.shadowRadius = 10 // any value you want
        CommuTableView.layer.shadowOffset = .init(width: 5, height: 10)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

}
