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

    var fortuneList: [String] = []

    @IBOutlet weak var backImage: UIImageView!
    @IBOutlet weak var labelSubTitle: UILabel!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelContent: UILabel!
    
    
    
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
        self.labelSubTitle.text = "\(name!)님의 오늘의 운세입니다."
            self.backImage.image = UIImage(named: "roll")
        labelContent.isHidden = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            UIView.transition(with: self.backImage,
                                  duration: 1.5,
                                  options: .transitionCrossDissolve,
                                  animations: {
                                      self.backImage.image = UIImage(named: "back")
                                  }, completion: nil)
            }
        
        labelContent.fadeIn()
        }



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
        
        
        if let tabBarItems = tabBarController?.tabBar.items {
            for item in tabBarItems {
                item.image = item.image?.withRenderingMode(.alwaysOriginal)
            }
        }
        
        self.backImage.image = UIImage(imageLiteralResourceName: "roll")
        labelTitle.font = UIFont(name: "NotoSerifKR-SemiBold", size: 28)
        
        labelSubTitle.font = UIFont(name: "NotoSerifKR-Medium", size: 22)
        
        labelContent.font = UIFont(name: "NotoSerifKR-Light", size: 17)
        
        loadFortuneFromCSV()
    }
    
    private func parseCSVAt(url: URL) {
        do {
            let data = try Data(contentsOf: url)
            let dataEncoded = String(data: data, encoding: .utf8)
            if var dataArr = dataEncoded?.components(separatedBy: "\n").map({$0}) {
                
                dataArr.removeLast()
                let fortune = dataArr.randomElement()
                
                if let fortune = fortune {
                    labelContent.text = fortune
                }
                
            }
        } catch {
            print("Error reading CSV file")
        }
    }
   
    private func loadFortuneFromCSV() {
        print("loading...")
        let path = Bundle.main.path(forResource: "today", ofType: "csv")!
        parseCSVAt(url: URL(fileURLWithPath: path))
    }
}
