//
//  AboutCollectionViewCell.swift
//  Resume
//
//  Created by Никита Новгородцев on 04.08.2023.
//

import UIKit

final class AboutTableViewCell: UITableViewCell {
    static let identifier = "AboutTableViewCell"
    
    //MARK: - titleLabel
    private let titleLabel: UILabel = {
        var lab = UILabel()
        lab.textColor = .black
        lab.font = UIFont.systemFont(ofSize: 18)
        lab.text = "О себе"
        lab.translatesAutoresizingMaskIntoConstraints = false
        
        return lab
    }()
    
    //MARK: - textView
    var textView: UITextView = {
        var textView = UITextView()
        textView.textColor = #colorLiteral(red: 0.2511924207, green: 0.2511924207, blue: 0.2511924207, alpha: 1)
        textView.font = .systemFont(ofSize: 17)
        textView.backgroundColor = .white
        textView.accessibilityIdentifier = "textAboutMe"
        textView.isScrollEnabled = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        
        return textView
    }()
    
    //MARK: - init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        
        //MARK: - titleLabel
        contentView.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 19),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: titleLabel.bottomAnchor)
        ])
        
        //MARK: - textView constraints
        contentView.addSubview(textView)
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            textView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            textView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
        ])
    }
    
    //MARK: - config
    func config(text: String) {
        self.textView.text = text
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
