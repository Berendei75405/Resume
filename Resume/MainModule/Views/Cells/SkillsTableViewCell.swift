//
//  SkillsCollectionViewCell.swift
//  Resume
//
//  Created by user on 01.08.2023.
//

import UIKit

protocol SkillsTableViewCellDataSource: AnyObject {
    func numberOfItems() -> Int
    func textForItem() -> [String]
}

protocol SkillsTableViewCellDelegate: AnyObject {
    func editMode(editMode: Bool)
    func cellWasSelect(index: Int)
    func deleteCell(index: Int)
}

final class SkillsTableViewCell: UITableViewCell {
    static let identifier = "SkillsTableViewCell"
    var editMode = false
    
    weak var dataSource: SkillsTableViewCellDataSource?
    weak var delegate: SkillsTableViewCellDelegate?
    
    //MARK: - collectionView
    lazy var collectionView: UICollectionView = {
        var collection = UICollectionView(frame: .zero,
                                          collectionViewLayout: createLayout())
        
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = .white
        collection.isScrollEnabled = false
        
        //регистрация яйчеек
        collection.register(SkillsCollectionViewCell.self,
                            forCellWithReuseIdentifier: SkillsCollectionViewCell.identifier)
        
        //регистрация header
        collection.register(SkillsSectionHeader.self,
                            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SkillsSectionHeader.identifier)
    
        collection.dataSource = self
        collection.delegate = self
        
        return collection
    }()
    
    //MARK: - init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        
        //MARK: - collectionView constraints
        contentView.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - createLayout
    private func createLayout() -> UICollectionViewLayout {
        UICollectionViewCompositionalLayout { sectionIndex, env in
            switch sectionIndex {
            case 0:
                let itemSize = NSCollectionLayoutSize(widthDimension: .estimated(80), heightDimension: .fractionalHeight(1))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(64))
                
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                group.contentInsets = .init(top: 16, leading: 16, bottom: .zero, trailing: 16)
                group.interItemSpacing = .fixed(16)
                
                let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(32))
                let header: NSCollectionLayoutBoundarySupplementaryItem = .init(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
                
                let section = NSCollectionLayoutSection(group: group)
                section.boundarySupplementaryItems = [header]
                section.contentInsets = .init(top: .zero, leading: .zero, bottom: 24, trailing: .zero)
                
                return section
            default:
                return NSCollectionLayoutSection(group: NSCollectionLayoutGroup(layoutSize: NSCollectionLayoutSize(widthDimension: .absolute(0), heightDimension: .absolute(0))))
            }
        }
    }
}

//MARK: - extensions
extension SkillsTableViewCell: UICollectionViewDelegate,
                               UICollectionViewDataSource,
                               SectionHeaderDelegateProtocol,
                               SkillsCollectionViewCellDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource?.numberOfItems() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SkillsCollectionViewCell.identifier, for: indexPath) as? SkillsCollectionViewCell else { return UICollectionViewCell() }
        
        cell.delegate = self
        
        let array = dataSource?.textForItem() ?? []
        if array.count != indexPath.row + 1 {
            cell.configurate(text: array[indexPath.row], editMode: self.editMode)
        } else {
            cell.configurate(text: array[indexPath.row], editMode: false)
            cell.accessibilityIdentifier = "addItem"
        }
        cell.deleteButton.tag = indexPath.row
        cell.deleteButton.accessibilityIdentifier = "deleteButton\(indexPath.row)"
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch indexPath.row {
        case .zero:
            guard let cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SkillsSectionHeader.identifier, for: indexPath) as? SkillsSectionHeader else { return UICollectionReusableView() }
            
            cell.delegate = self
            
            return cell
        default:
            return UICollectionReusableView()
        }
    }
    
    //MARK: - SectionHeaderDelegateProtocol
    func editTap(editMode: Bool) {
        self.editMode.toggle()
        self.delegate?.editMode(editMode: editMode)
        collectionView.reloadData()
    }
    
    //MARK: - SkillsCollectionViewCellDelegate
    func itemWasSelect(index: Int) {
        self.delegate?.cellWasSelect(index: index)
    }
    
    func deleteCell(index: Int) {
        self.delegate?.deleteCell(index: index)
        collectionView.reloadData()
    }
    
}
