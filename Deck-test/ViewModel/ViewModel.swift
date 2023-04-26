//
//  ViewModel.swift
//  Deck-test
//
//  Created by Линар Нигматзянов on 25/04/2023.
//

import Foundation
import RxCocoa
import RxSwift


final class StudentViewModel {
    
    var students = BehaviorRelay<[Student]>(value: [])
    
    func fetch() {
        let array = [
            Student(firstName: "ivan", lastName: "ivaniv", age: 20, city: "kazan"),
            Student(firstName: "petr", lastName: "sidorov", age: 22, city: "moscow"),
            Student(firstName: "maks", lastName: "safin", age: 21, city: "SPB"),
            Student(firstName: "dinar", lastName: "sahirov", age: 23, city: "Novgorod")
        ]
        
        students.accept(array)
    }
}
