//
//  SectionHeader.swift
//  Resume
//
//  Created by user on 01.08.2023.
//

import UIKit

protocol SectionHeaderDelegateProtocol: AnyObject {
    func editTap(editMode: Bool)
}

final class SkillsSectionHeader: UICollectionReusableView {
    static let identifier = "SkillsSectionHeader"
    
    weak var delegate: SectionHeaderDelegateProtocol?
    
    //MARK: - titleLabel
    private let titleLabel: UILabel = {
        var lab = UILabel()
        lab.textColor = .black
        lab.font = UIFont.systemFont(ofSize: 18)
        lab.text = "Мои навыки"
        lab.translatesAutoresizingMaskIntoConstraints = false
        
        return lab
    }()
    
    //MARK: - editButton
    private var editButton: UIButton = {
        var but = UIButton()
        but.setImage(UIImage(named: "pensill"), for: .normal)
        but.translatesAutoresizingMaskIntoConstraints = false
        but.accessibilityIdentifier = "editButton"
        
        return but
    }()
    
    //MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
        backgroundColor = .white
    }
    
    //MARK: - setupConstraints
    private func setupConstraints() {
        addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        editButton.addTarget(self, action: #selector(editTap), for: .touchUpInside)
        
        addSubview(editButton)
        NSLayoutConstraint.activate([
            editButton.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            editButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            editButton.widthAnchor.constraint(equalToConstant: 26),
            editButton.heightAnchor.constraint(equalToConstant: 26)
        ])
    }
    
    //MARK: - editTap
    @objc private func editTap() {
        if editButton.imageView?.image == UIImage(named: "pensill") {
            editButton.setImage(UIImage(named: "success"), for: .normal)
            delegate?.editTap(editMode: true)
        } else {
            editButton.setImage(UIImage(named: "pensill"), for: .normal)
            delegate?.editTap(editMode: false)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
