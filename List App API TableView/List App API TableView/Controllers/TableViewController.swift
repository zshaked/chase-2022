//
//  ViewController.swift
//  List App API TableView
//
//  Created by 123456 on 3/21/22.
//

import UIKit

final class TableViewController: UIViewController {
    
    private let networkManager: SchoolNetworkManager = .init()
    
    private var highSchools:[HighSchool] = .init()
    
    private let refreshControl = UIRefreshControl()
    
    private let activityIndicatorView:UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()

    lazy var tableView:UITableView = {
        let table = UITableView(frame: view.bounds)
        table.delegate = self
        table.dataSource = self
        table.register(SATCell.self, forCellReuseIdentifier: SATCell.reuseIdentifier)
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "High Schools"
        activityIndicatorView.startAnimating()
        fetchSchools()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        view.addSubview(tableView)
        view.addSubview(activityIndicatorView)
         
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            activityIndicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            activityIndicatorView.heightAnchor.constraint(equalToConstant: 40),
            activityIndicatorView.widthAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    // MARK: - API
    private func fetchSchools() {
        networkManager.fetchSchools { [weak self] result in
            switch result {
            case .success(let schools):
                schools.forEach { print($0) }
                DispatchQueue.main.async {
                    guard let self = self else{
                        return
                    }
                    self.highSchools = schools
                    self.tableView.reloadData()
                    self.refreshControl.endRefreshing()
                    self.activityIndicatorView.stopAnimating()
                }
                
            case .failure(let error):
                print(error)
                DispatchQueue.main.async { [weak self] in
                    
                    guard let self = self else{
                        return
                    }
                    let alert = UIAlertController(title: "Unable to perform request at this time", message: "Please check your connection and try again", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Close", style: .destructive, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    self.refreshControl.endRefreshing()
                  self.activityIndicatorView.stopAnimating()
                }
            }
        }
    }


}

//MARK: TableView Datasource
extension TableViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return highSchools.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SATCell.reuseIdentifier, for: indexPath) as? SATCell else{
            fatalError("failed to dequeue cell")
        }
        let school = highSchools[indexPath.row]
        cell.setUpCell(school:school)
        return cell
    }
    
    
}

//MARK: TableView Delegate
extension TableViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let school = self.highSchools[indexPath.row]
        let detailVC = DetailViewController()
        detailVC.school = school
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return 40
    }
}
