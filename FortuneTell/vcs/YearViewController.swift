//
//  YearViewController.swift
//  FortuneTell
//
//  Created by 22 on 12/19/24.
//

import UIKit

class YearViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var labelTitle: UILabel!
    
    //월 선택
    let month: [String] = ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"]
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return month.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?{
        return month[row]
    }
    
    

    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            self.imageView.image = UIImage(named: "roll")
        }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerView.delegate = self
        pickerView.dataSource = self
        self.imageView.image = UIImage(imageLiteralResourceName: "roll")
        
        
        if let tabBarItems = tabBarController?.tabBar.items {
            for item in tabBarItems {
                item.image = item.image?.withRenderingMode(.alwaysOriginal)
            }
        }
    }
    


    @IBAction func selectMonth(_ sender: UIButton) {
        
        let selectedRow = pickerView.selectedRow(inComponent: 0)
            let selectedMonth = month[selectedRow]
            labelTitle.text = "ㅁㅁ 님의 \(selectedMonth) 신년운세입니다."
        
        
        self.imageView.image = UIImage(named: "roll")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                UIView.transition(with: self.imageView,
                                  duration: 1.5,
                                  options: .transitionCrossDissolve,
                                  animations: {
                                      self.imageView.image = UIImage(named: "back")
                                  }, completion: nil)
            }
        
//        UIView.transition(with: self.imageView,
//                          duration: 2.0,
//                          options: .transitionCrossDissolve,
//                          animations: {
//                            self.imageView.image = UIImage(imageLiteralResourceName: "back")
//        }, completion: nil)
    }
    

}
