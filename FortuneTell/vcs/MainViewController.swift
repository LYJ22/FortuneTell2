//
//  MainViewController.swift
//  FortuneTell
//
//  Created by lyj on 12/19/24.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // 네비게이션 바 배경색, 크기 설정
        //UINavigationBar.appearance().backgroundColor = UIColor(red: 255.0/255.0, green: 158.0/255.0, blue: 7.0/255.0, alpha: 1.0)
        //UINavigationBar.appearance().tintColor = .black
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(red: 255.0/255.0, green: 158.0/255.0, blue: 7.0/255.0, alpha: 1.0)
        navigationController?.navigationBar.tintColor = .black
        navigationController?.additionalSafeAreaInsets.top = 20
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    

    
    @IBAction func buttonOk(_ sender: UIButton) {
        
    }
    
    
    
}




