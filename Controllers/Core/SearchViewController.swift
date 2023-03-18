//
//  SearchViewController.swift
//  Netflix Clone
//
//  Created by Vladlens Kukjans on 13/03/2023.
//

import UIKit

class SearchViewController: UIViewController {
    
    private var titles: [Title] = [Title]()
    
    private let discoverTable: UITableView = {
    let table = UITableView()
    table.register(TitleTableViewCell.self, forCellReuseIdentifier: TitleTableViewCell.identifier)
    return table
    }()
    
    private let searchController: UISearchController = {
        let search = UISearchController(searchResultsController: SearchResultsViewController())
        search.searchBar.placeholder = "Search for Movie or a Tv show"
        search.searchBar.searchBarStyle = .minimal
        search.obscuresBackgroundDuringPresentation = false
        search.definesPresentationContext = true
        search.hidesNavigationBarDuringPresentation = false
        return search
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        title = "Search"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        
        view.addSubview(discoverTable)
        discoverTable.delegate = self
        discoverTable.dataSource = self
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationController?.navigationBar.tintColor = .white
        
        searchController.searchResultsUpdater = self
        fetchDiscoverMovies()
    }
    
    private func fetchDiscoverMovies() {
        APICaller.shared.getDiscoverMovies { [weak self] result in
            switch result {
                
            case .success(let titles):
                self?.titles = titles
                DispatchQueue.main.async {
                self?.discoverTable.reloadData()
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        discoverTable.frame = view.bounds
    }
    }

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCell.identifier, for: indexPath) as? TitleTableViewCell else {
            return UITableViewCell()
        }
        
        let title = titles[indexPath.row]
        let model = TitleViewModel(titleName: title.original_name ?? title.original_title ?? "Unknown Name", posterURL: title.poster_path ?? "")
        cell.configure(with: model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let title = titles[indexPath.row]
        
        guard let titleName = title.original_title ?? title.original_name else {return}
        
        APICaller.shared.getMovie(with: titleName) { [weak self] result in
            switch result {
                
            case .success(let videoElement):
                DispatchQueue.main.async {
            let vc = TitlePreviewViewController()
            vc.configure(with: TitlePreviewVIewModel(title: titleName, youtubeVideo: videoElement, titleOverview: title.overview ?? ""))
            self?.navigationController?.pushViewController(vc, animated: true)
        }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
    }
}
extension SearchViewController: UISearchResultsUpdating, SearchResultsViewControllerDelegate {
    
    func searchResultsViewControllerDidTapItem(_ viewModel: TitlePreviewVIewModel) {
        DispatchQueue.main.async { [weak self] in
            let vc = TitlePreviewViewController()
            vc.configure(with: viewModel)
            self?.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    // UISerchController Update
    func updateSearchResults(for searchController: UISearchController) {
        let serchBar = searchController.searchBar
        
        guard let query = serchBar.text,
              !query.trimmingCharacters(in: .whitespaces).isEmpty,
              query.trimmingCharacters(in: .whitespaces).count >= 3,
              let resultController = searchController.searchResultsController as? SearchResultsViewController else {return}
        
        resultController.delegate = self
        
        APICaller.shared.search(with: query) { results in
            DispatchQueue.main.async {
                switch results {
                case .success(let titles):
                    resultController.titles = titles
                    resultController.searchResultsCollectionView.reloadData()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    
    
    
}
    
