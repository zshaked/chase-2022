//
//  SATCell.swift
//  List App API TableView
//
//  Created by 123456 on 3/21/22.
//

import UIKit

class SATCell:UITableViewCell{
    
    static let reuseIdentifier: String = "SATCell"

    lazy var schoolNameLabel:UILabel = {
        let label:UILabel = UILabel(frame: self.bounds)
        label.textAlignment = .center
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        selectionStyle = .none
    }
    
    
    func setUpCell(school:HighSchool){
        schoolNameLabel.text = school.name
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.addSubview(schoolNameLabel)
        
        NSLayoutConstraint.activate([
            schoolNameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            schoolNameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            schoolNameLabel.heightAnchor.constraint(equalTo: heightAnchor),
            schoolNameLabel.widthAnchor.constraint(equalTo: widthAnchor)
        ])
    }
    
}
