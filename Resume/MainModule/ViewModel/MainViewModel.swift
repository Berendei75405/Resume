//
//  MainViewModel.swift
//  Resume
//
//  Created by user on 01.08.2023.
//

protocol MainViewModelProtocol: AnyObject {
    var skills: [String] {get set}
    var text: String {get set}
    func deleteItem(index: Int)
    func appendItem(title: String)
}

import Foundation

final class MainViewModel: MainViewModelProtocol {
    var coordinator: MainCoordinatorProtocol!
    var skills: [String] = ["Core Data", "Swift",
                            "UIKit", "JSON API",
                            "MVVM", "MVC", "GCD",
                            "Combine", "Git", "MVP",
                            "Postman", "ООП"]
    var text: String = "Я являюсь ответственным и мотивированным IOS разработчиком с опытом работы над различными проектами. Cтремлюсь к постоянному совершенствованию и открыт новым вызовам в сфере разработки IOS приложений. Умею работать с такими архитектурными паттернами , как MVVM, MVP, MVC и доказал это на своих проектах. Так же я знаком с некоторыми библиотеками и инструментами, такими как Alamofire, SnapKit, GCD , Combine, CoreData, JSON API. Я всегда стремлюсь учиться и развиваться, поэтому готов работать над сложными задачами и изучать новые технологии."  
    
    //MARK: - deleteItem
    func deleteItem(index: Int) {
        skills.remove(at: index)
    }
    
    //MARK: - appendItem
    func appendItem(title: String) {
        skills.append(title)
    }
    
}
