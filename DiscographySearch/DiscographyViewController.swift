//
//  ViewController.swift
//  DiscographySearch
//
//  Created by Sul S. on 8/31/21.
//

import UIKit

class DiscographyViewController: UIViewController {
    var discographyTableView = UITableView()
    let apiManager = APIManager.shared
    let discographyVM = DiscographyViewModel.init()
    let search = UISearchController(searchResultsController: nil)
    
    func setupSearch() {
        search.searchResultsUpdater = self
        search.obscuresBackgroundDuringPresentation = false
        discographyTableView.tableHeaderView = search.searchBar
        search.searchBar.placeholder = "Search..."
        //navigationItem.searchController = search
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        discographyTableView = UITableView(frame: self.view.bounds)
        discographyTableView.dataSource = self
        discographyTableView.delegate = self
        discographyTableView.register(DiscographyTableViewCell.self, forCellReuseIdentifier: "cell")
        setupSearch()
        view.addSubview(discographyTableView)
    }
}

extension DiscographyViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return discographyVM.getRowCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        let track = discographyVM.getTrackAtIndex(index: indexPath.row)
        cell?.textLabel?.numberOfLines = 0
        cell?.textLabel?.text =
            "Artist: \(discographyVM.getArtistName(track: track))\nTrack: \(discographyVM.getTrackName(track: track))"
        return cell ?? DiscographyTableViewCell()
    }
}

extension DiscographyViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let url = URL.init(
                string: "https://itunes.apple.com/search?term=\(search.searchBar.text ?? "")")
        else { return }
        discographyVM.get(url: url, type: Discography.self) {
            self.discographyTableView.reloadData()
        }
        
    }
    
    
}

