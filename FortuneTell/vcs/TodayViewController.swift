//
//  TodayViewController.swift
//  FortuneTell
//
//  Created by 22 on 12/19/24.
//

import UIKit

class TodayViewController: UIViewController {
    var name: String?
    var gender: String?
    var dateType: String?
    var date: String?
    var time: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        if let name = name {
            print("넘어온 값 name: \(name)")
        }
        if let gender = gender {
            print("넘어온 값 gender: \(gender)")
        }
        if let dateType = dateType {
            print("넘어온 값 dateType: \(dateType)")
        }
        if let date = date {
            print("넘어온 값 date: \(date)")
        }
        if let time = time {
            print("넘어온 값 time: \(time)")
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
