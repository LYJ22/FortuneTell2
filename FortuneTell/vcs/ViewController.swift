//
//  ViewController.swift
//  FortuneTell
//
//  Created by lyj on 12/19/24.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0){
            self.showScreen(withIdentifier: "mainViewController")
        }
    }

    private func showScreen(withIdentifier: String){
        if let mainVC = storyboard?.instantiateViewController(withIdentifier: withIdentifier){
            mainVC.modalTransitionStyle = .crossDissolve // 부드러운 화면 효과
            mainVC.modalPresentationStyle = .fullScreen
            self.present(mainVC, animated: true, completion: nil)
        }
    }
}

