//
//  TopMovieTableView.swift
//  RMovie
//
//  Created by Hai on 1/14/17.
//  Copyright © 2017 Techkids. All rights reserved.
//

import UIKit

class TopMovieTableView: UITableView, UITableViewDataSource, UITableViewDelegate {
    
    var topMovie : [Movie]?
    var topTv : [Movie]?
    var topMovie2016 : [Movie]?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.delegate = self
        self.dataSource = self
    }
    
    func setUP () {
        self.backgroundColor = .none
        let nib = UINib(nibName: "TopMovieTableViewCell", bundle: nil)
        self.register(nib, forCellReuseIdentifier: "TopMovieTableViewCell")
        self.rowHeight = self.frame.height * 1.3/3
        print("1111", self.topTv?.count)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = dequeueReusableCell(withIdentifier: "TopMovieTableViewCell", for: indexPath) as! TopMovieTableViewCell
        cell.setUP()
        switch indexPath.row {
        case 0:
            cell.movies = self.topMovie
            print("1111112",cell.movies.count)
            cell.labelName.text = "Top Movie"
        case 1:
            cell.movies = self.topTv
            cell.labelName.text = "Top TV Series"
        default:
            cell.movies = self.topMovie2016
            cell.labelName.text = "Top Movie in 2016"
        }
        return cell
    }
    
}

