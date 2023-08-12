//
//  SkillsCollectionViewCell.swift
//  Resume
//
//  Created by Никита Новгородцев on 06.08.2023.
//

import UIKit

protocol SkillsCollectionViewCellDelegate: AnyObject {
    func itemWasSelect(index: Int)
    func deleteCell(index: Int)
}

final class SkillsCollectionViewCell: UICollectionViewCell {
    static let identifier = "SkillsTableViewCell"
    
    weak var delegate: SkillsCollectionViewCellDelegate?
    
    //MARK: - infoLabel
    private let infoLabel: UILabel = {
        var lab = UILabel()
        lab.textColor = #colorLiteral(red: 0.2511924207, green: 0.2511924207, blue: 0.2511924207, alpha: 1)
        lab.font = UIFont.systemFont(ofSize: 15)
        lab.translatesAutoresizingMaskIntoConstraints = false
        lab.textAlignment = .center
        lab.numberOfLines = 1
        
        return lab
    }()
    
    //MARK: - deleteButton
    lazy var deleteButton: UIButton = {
        var but = UIButton()
        but.setImage(UIImage(systemName: "xmark"), for: .normal)
        but.translatesAutoresizingMaskIntoConstraints = false
        but.tintColor = #colorLiteral(red: 0.2511924207, green: 0.2511924207, blue: 0.2511924207, alpha: 1)
        
        return but
    }()
    
    //MARK: - tap
    lazy var tap = UITapGestureRecognizer(target: self, action: #selector(addButtonAction))
    
    //MARK: - stackView
    private lazy var stackView: UIStackView = {
        var stack = UIStackView(arrangedSubviews: [infoLabel, deleteButton])
        stack.axis = .horizontal
        stack.alignment = .center
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        return stack
    }()
    
    //MARK: - init
    override init(frame: CGRect) {
        super .init(frame: frame)
        contentView.backgroundColor = #colorLiteral(red: 0.9625495076, green: 0.9627465606, blue: 0.9688358903, alpha: 1)
        contentView.layer.cornerRadius = 10
        deleteButton.addTarget(self, action: #selector(deleteButtonAction(sender:)), for: .touchUpInside)
        
        stackView.addGestureRecognizer(tap)
        
        contentView.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - addButtonAction
    @objc func addButtonAction() {
        self.delegate?.itemWasSelect(index: deleteButton.tag)
    }
    
    //MARK: - deleteButtonAction
    @objc private func deleteButtonAction(sender: UIButton) {
        self.delegate?.deleteCell(index: sender.tag)
    }
    
    //MARK: - configurate
    func configurate(text: String, editMode: Bool = false) {
        self.infoLabel.text = text
        self.deleteButton.isHidden = !editMode
    }
}
