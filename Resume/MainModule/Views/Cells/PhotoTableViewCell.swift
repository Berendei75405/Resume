//
//  PhotoCollectionViewCell.swift
//  Resume
//
//  Created by Никита Новгородцев on 04.08.2023.
//

import UIKit

final class PhotoTableViewCell: UITableViewCell {
    static let identifier = "PhotoTableViewCell"
    
    //MARK: - photoImageView
    private var photoImageView: UIImageView = {
        var img = UIImageView()
        img.image = UIImage(named: "photo")
        img.translatesAutoresizingMaskIntoConstraints = false
        img.contentMode = .scaleAspectFill
        img.frame.size = CGSize(width: 120, height: 120)
        img.layer.cornerRadius = img.frame.width/2
        img.clipsToBounds = true
        
        return img
    }()
    
    //MARK: - fullNameLabel
    private let fullNameLabel: UILabel = {
        var lab = UILabel()
        lab.translatesAutoresizingMaskIntoConstraints = false
        lab.text = "Новгородцев Никита Александрович"
        lab.lineBreakMode = .byWordWrapping
        lab.numberOfLines = 0
        lab.textAlignment = .center
        lab.textColor = .black
        lab.font = .boldSystemFont(ofSize: 24)
        
        return lab
    }()
    
    //MARK: - personInfoLabel
    private let personInfoLabel: UILabel = {
        var lab = UILabel()
        lab.translatesAutoresizingMaskIntoConstraints = false
        lab.text = "Junior IOS-разработчик, опыт более 1 года"
        lab.lineBreakMode = .byWordWrapping
        lab.textAlignment = .center
        lab.numberOfLines = 2
        lab.textColor = #colorLiteral(red: 0.6537411213, green: 0.6508514285, blue: 0.6713269949, alpha: 1)
        lab.font = .systemFont(ofSize: 14)
        
        return lab
    }()
    
    //MARK: - locationImageView
    private let locationImageView: UIImageView = {
        var img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.image = UIImage(named: "location")
        
        return img
    }()
    
    //MARK: - locationLabel
    private let locationLabel: UILabel = {
        var lab = UILabel()
        lab.translatesAutoresizingMaskIntoConstraints = false
        lab.text = "Барнаул"
        lab.lineBreakMode = .byWordWrapping
        lab.textAlignment = .center
        lab.numberOfLines = 1
        lab.textColor = #colorLiteral(red: 0.6537411213, green: 0.6508514285, blue: 0.6713269949, alpha: 1)
        lab.font = .systemFont(ofSize: 14)
        
        return lab
    }()
    
    //MARK: - init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = #colorLiteral(red: 0.9625495076, green: 0.9627465606, blue: 0.9688358903, alpha: 1)
        
        //MARK: - photoImageView constraints
        contentView.addSubview(photoImageView)
        NSLayoutConstraint.activate([
            photoImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 32),
            photoImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            photoImageView.widthAnchor.constraint(equalToConstant: 120),
            photoImageView.heightAnchor.constraint(equalToConstant: 120)
        ])
        
        //MARK: - fullNameLabel constraints
        contentView.addSubview(fullNameLabel)
        NSLayoutConstraint.activate([
            fullNameLabel.topAnchor.constraint(equalTo: photoImageView.bottomAnchor, constant: 16),
            fullNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: -32),
            fullNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
        
        //MARK: - personInfoLabel constraints
        contentView.addSubview(personInfoLabel)
        NSLayoutConstraint.activate([
            personInfoLabel.topAnchor.constraint(equalTo: fullNameLabel.bottomAnchor, constant: 4),
            personInfoLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            personInfoLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32)
        ])
        
        //MARK: - locationLabel constraints
        contentView.addSubview(locationLabel)
        NSLayoutConstraint.activate([
            locationLabel.topAnchor.constraint(equalTo: personInfoLabel.bottomAnchor, constant: 3),
            locationLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
        
        //MARK: - locationImageView constraints
        contentView.addSubview(locationImageView)
        NSLayoutConstraint.activate([
            locationImageView.topAnchor.constraint(equalTo: personInfoLabel.bottomAnchor),
            locationImageView.trailingAnchor.constraint(equalTo: locationLabel.leadingAnchor),
            locationImageView.widthAnchor.constraint(equalToConstant: 20),
            locationImageView.heightAnchor.constraint(equalToConstant: 20)
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

