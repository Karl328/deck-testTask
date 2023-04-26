//
//  ViewController.swift
//  Deck-test
//
//  Created by Линар Нигматзянов on 25/04/2023.
//

import UIKit
import RxSwift
import RxCocoa


final class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private let bag = DisposeBag()
    private let viewModel = StudentViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rx.setDelegate(self).disposed(by: bag)
        
        bindTableView()
    }
    
    
    private func bindTableView () {
        
        tableView.register(UINib(nibName: "StudentsTableViewCell", bundle: nil), forCellReuseIdentifier:
                            "cell"
        )
        viewModel.fetch()
        
        viewModel.students.bind(to: tableView.rx.items(cellIdentifier: "cell", cellType: StudentsTableViewCell.self)) { (row, item, cell) in
            cell.firstName.text = item.firstName
            cell.lastName.text = item.lastName
            cell.age.text = String(item.age)
            cell.city.text = item.city
            
        }.disposed(by: bag)
        
        tableView.rx.modelSelected(Student.self).subscribe (onNext: { [unowned self] item in
            guard let detailsVC = self.storyboard?.instantiateViewController(withIdentifier: "DetailsViewController") as? DetailsViewController else {fatalError("DetailsViewController not found")}
            
            detailsVC.student.onNext(item)
            
            detailsVC.student
                .withLatestFrom(self.viewModel.students) { newStudent, students in
                    var updatedStudents = students
                    if let index = students.firstIndex(where: { $0.firstName == newStudent?.firstName }) {
                        updatedStudents[index] = newStudent!
                    }
                    return updatedStudents
                }
                .bind(to: self.viewModel.students)
                .disposed(by: self.bag)
            
            self.navigationController?.pushViewController(detailsVC, animated: true)
            
        }).disposed(by: bag)
        
    }
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
}
