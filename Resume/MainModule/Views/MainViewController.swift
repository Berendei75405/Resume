//
//  ViewController.swift
//  Resume
//
//  Created by user on 01.08.2023.
//

import UIKit

final class MainViewController: UIViewController {
    
    var viewModel: MainViewModelProtocol!
    private var keyboardHeight: CGFloat = 0 {
        didSet {
            tableView.beginUpdates()
            tableView.endUpdates()
        }
    }
    private lazy var tap = UITapGestureRecognizer(target: self, action: #selector(tapAction))
    
    //MARK: - tableView
    private lazy var tableView: UITableView = {
        var table = UITableView(frame: .zero, style: .plain)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.separatorStyle = .none
        table.backgroundColor = #colorLiteral(red: 0.9625495076, green: 0.9627465606, blue: 0.9688358903, alpha: 1)
        
        //регистрация яйчеек
        table.register(PhotoTableViewCell.self, forCellReuseIdentifier: PhotoTableViewCell.identifier)
        
        table.register(SkillsTableViewCell.self, forCellReuseIdentifier: SkillsTableViewCell.identifier)
        
        table.register(AboutTableViewCell.self, forCellReuseIdentifier: AboutTableViewCell.identifier)
        
        table.dataSource = self
        table.delegate = self
        
        view.addSubview(table)
        
        return table
    }()
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Профиль"
        view.addGestureRecognizer(tap)
        setConstraints()
        setupNotifications()
    }
    
    //MARK: - setConstraints
    private func setConstraints() {
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    //MARK: - tapAction
    @objc private func tapAction() {
        let cell = tableView.cellForRow(at: IndexPath(row: 2, section: 0)) as? AboutTableViewCell
        cell?.textView.resignFirstResponder()
    }
    
    //MARK: - setupNotifications
    private func setupNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    //MARK: - keyboardWillShow
    @objc private func keyboardWillShow(notification: Notification) {
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        self.keyboardHeight = keyboardFrame.height
    }
    
    //MARK: - keyboardWillHide
    @objc private func keyboardWillHide() {
        self.keyboardHeight = 0
    }
}

//MARK: - extensions
extension MainViewController: UITableViewDelegate,
                              UITableViewDataSource,
                              SkillsTableViewCellDataSource, SkillsTableViewCellDelegate,
                              UITextFieldDelegate {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case .zero:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PhotoTableViewCell.identifier, for: indexPath) as? PhotoTableViewCell else { return UITableViewCell() }
            
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SkillsTableViewCell.identifier, for: indexPath) as? SkillsTableViewCell else { return UITableViewCell() }
            cell.selectionStyle = .none
            
            cell.dataSource = self
            cell.delegate = self
            
            return cell
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: AboutTableViewCell.identifier) as? AboutTableViewCell else { return UITableViewCell() }
            
            cell.selectionStyle = .none
            cell.config(text: viewModel.text)
            
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case .zero:
            return 290
        case 1:
            return 360
        case 2:
            let padding = CGFloat(16)
            let header = CGFloat(32)
            let font = UIFont.systemFont(ofSize: 18)
            let width = tableView.frame.width - padding * 2
            let text = viewModel.text
            let size = CGSize(width: width, height: .infinity)
            let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
            let estimatedHeight = NSString(string: text).boundingRect(with: size, options: options, attributes: [NSAttributedString.Key.font: font], context: nil).height + header
            if self.keyboardHeight == 0 {
                return estimatedHeight
            } else {
                return estimatedHeight + self.keyboardHeight + 200
            }
        default:
            return 0
        }
    }
    
    //MARK: - SkillsTableViewCellDataSource
    func numberOfItems() -> Int {
        return viewModel.skills.count
    }
    
    func editMode(editMode: Bool) {
        if editMode {
            viewModel.skills.append("+")
        } else {
            viewModel.skills.removeAll { $0 == "+" }
        }
    }
    
    func cellWasSelect(index: Int) {
        if (viewModel.skills.count == index + 1) && isEditing == false {
            let alertController = UIAlertController(title: "Добавление навыка", message: "Введите название навыка которым вы владеете", preferredStyle: .alert)
            alertController.addTextField { textField in
                textField.placeholder = "Введите название"
                textField.accessibilityIdentifier = "Введите название"
                textField.delegate = self
            }
            let actionCancel = UIAlertAction(title: "Отмена", style: .cancel)
            let actionAdd = UIAlertAction(title: "Добавить", style: .default) { action in
                guard let txt = alertController.textFields?.first?.text else { return }
                self.viewModel.skills.append(txt)
            }
            alertController.addAction(actionCancel)
            alertController.addAction(actionAdd)
            present(alertController, animated: true)
        }
    }
    
    func deleteCell(index: Int) {
        viewModel.deleteItem(index: index)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField.text?.count == 33 {
            textField.text?.removeLast()
        }
        
        return true
    }
    
    func textForItem() -> [String] {
        return viewModel.skills
    }
}
