//
//  MovieReviewView.swift
//  RMovie
//
//  Created by Hai on 1/8/17.
//  Copyright © 2017 Techkids. All rights reserved.
//

import UIKit

class MovieReviewView: UIView, UITableViewDelegate, UITableViewDataSource {
    
    var reviews : [String]!
    
    @IBOutlet weak var reviewTable: UITableView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let nib = UINib(nibName: "MovieReviewCell", bundle: nil)
        self.reviewTable.register(nib, forCellReuseIdentifier: "MovieReviewCell")
        self.reviewTable.estimatedRowHeight = 30
        self.reviewTable.rowHeight = UITableViewAutomaticDimension
        self.reviewTable.dataSource = self
        self.reviewTable.delegate = self
        self.reviewTable.backgroundColor = .none
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.reviews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieReviewCell", for: indexPath) as! MovieReviewCell
        
        cell.reviewContent.text = self.reviews[indexPath.row]
        
        return cell
    }
}
