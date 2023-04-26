//
//  DetailsViewController.swift
//  Deck-test
//
//  Created by Линар Нигматзянов on 25/04/2023.
//

import UIKit
import RxCocoa
import RxSwift

final class DetailsViewController: UIViewController {
    
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var age: UITextField!
    @IBOutlet weak var city: UITextField!
    
    private var bag = DisposeBag()
    
    var student = BehaviorSubject<Student?>(value: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstName.isUserInteractionEnabled = false
        lastName.isUserInteractionEnabled = false
        
        student.subscribe (onNext: { [unowned self] student in
            self.firstName.text = student?.firstName
            self.lastName.text = student?.lastName
            self.age.text = String(student?.age ?? 0)
            self.city.text = student?.city
        }).disposed(by: bag)
        
    }
    
    @IBAction func saveButton(_ sender: UIButton) {
        let newStudent = Student(firstName: firstName.text!, lastName: lastName.text!, age: Int(age.text!) ?? 0, city: city.text!)
        self.student.onNext(newStudent)
        
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    
}
