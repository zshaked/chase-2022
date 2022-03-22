//
//  DetailViewController.swift
//  List App API TableView
//
//  Created by 123456 on 3/22/22.
//

import UIKit

class DetailViewController:UIViewController{
    
    var school:HighSchool!
    var SAT:SAT!{
        didSet{
            self.readingLabel.text! += SAT.reading
            self.writingLabel.text! += SAT.writing
            self.totalLabel.text! += SAT.totalTakers
            self.mathLabel.text! += SAT.math
        }
    }
    private var networkManager:SchoolNetworkManager = SchoolNetworkManager()
    
    lazy var activityIndicatorView:UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.startAnimating()
        return indicator
    }()
    
    lazy var mathLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.text = "SAT Math: "
        return label
    }()
    
    lazy var readingLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.text = "SAT Reading: "
        return label
    }()
    
    lazy var writingLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.text = "SAT Writing: "
        return label
    }()
    
    lazy var totalLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.text = "SAT Total Takers: "
        return label
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = school.name
        view.backgroundColor = .systemBackground
        fetchSAT()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        view.addSubview(writingLabel)
        view.addSubview(readingLabel)
        view.addSubview(mathLabel)
        view.addSubview(totalLabel)
        view.addSubview(activityIndicatorView)
        
        NSLayoutConstraint.activate([
            writingLabel.heightAnchor.constraint(equalToConstant: 30),
            writingLabel.widthAnchor.constraint(equalTo: view.widthAnchor),
            writingLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            writingLabel.bottomAnchor.constraint(equalTo: view.centerYAnchor, constant: -60),
            
            readingLabel.heightAnchor.constraint(equalToConstant: 30),
            readingLabel.widthAnchor.constraint(equalTo: view.widthAnchor),
            readingLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            readingLabel.topAnchor.constraint(equalTo: writingLabel.bottomAnchor, constant: 0),
            
            mathLabel.heightAnchor.constraint(equalToConstant: 30),
            mathLabel.widthAnchor.constraint(equalTo: view.widthAnchor),
            mathLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mathLabel.topAnchor.constraint(equalTo: readingLabel.bottomAnchor, constant: 0),
            
            totalLabel.heightAnchor.constraint(equalToConstant: 30),
            totalLabel.widthAnchor.constraint(equalTo: view.widthAnchor),
            totalLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            totalLabel.topAnchor.constraint(equalTo: mathLabel.bottomAnchor, constant: 0),
            
            activityIndicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            activityIndicatorView.heightAnchor.constraint(equalToConstant: 40),
            activityIndicatorView.widthAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    // MARK: - API
    private func fetchSAT() {
        networkManager.fetchSAT(schoolID: self.school.id){ [weak self] result in
            switch result {
            case .success(let sats):
                DispatchQueue.main.async {
                    guard let self = self, let sat = sats.first else{
                        return
                    }
                    self.SAT = sat
//                    self.refreshControl.endRefreshing()
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
//                    self.refreshControl.endRefreshing()
                    self.activityIndicatorView.stopAnimating()
                }
            }
        }
    }
    
    
    
}
