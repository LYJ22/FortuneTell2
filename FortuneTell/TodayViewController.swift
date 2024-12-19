//
//  TodayViewController.swift
//  FortuneTell
//
//  Created by 22 on 12/19/24.
//

import UIKit

class TodayViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // 탭바 아이템의 이미지 색상 변경 방지
        if let tabBarItems = tabBarController?.tabBar.items {
            for item in tabBarItems {
                item.image = item.image?.withRenderingMode(.alwaysOriginal)
            }
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
