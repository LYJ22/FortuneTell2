//
//  YearViewController.swift
//  FortuneTell
//
//  Created by 22 on 12/19/24.
//

import UIKit

extension UIView {
    public func fadeIn(duration: TimeInterval = 1.5, delay: TimeInterval = 1.0, completion: ((Bool) -> Void)? = nil) {
        self.alpha = 0.0
        self.isHidden = false
        UIView.animate(withDuration: duration, delay: delay, options: .transitionFlipFromRight, animations: {
            self.alpha = 1.0
        }, completion: completion)
    }

}


class YearViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    var fortuneList: [FortuneModel] = []
    var name: String?
    var gender: String?
    var dateType: String?
    var date: String?
    var time: String?
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var labelContent: UILabel!
    @IBOutlet weak var yearTitle: UILabel!
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
            self.contentView.isHidden = true
        self.labelTitle.text = "월별 신년운세"
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
        
        pickerView.delegate = self
        pickerView.dataSource = self
        self.imageView.image = UIImage(imageLiteralResourceName: "roll")
        //labelContent.isHidden = true
        contentView.isHidden = true
        
        
        yearTitle.font = UIFont(name: "NotoSerifKR-SemiBold", size: 28)
        
        labelTitle.font = UIFont(name: "NotoSerifKR-Medium", size: 22)
        
        labelContent.font = UIFont(name: "NotoSerifKR-Light", size: 17)
        
//        for family in UIFont.familyNames {
//            print("Font family: \(family)")
//            for font in UIFont.fontNames(forFamilyName: family) {
//                print("Font name: \(font)")
//            }
//        }
        if let tabBarItems = tabBarController?.tabBar.items {
            for item in tabBarItems {
                item.image = item.image?.withRenderingMode(.alwaysOriginal)
            }
        }
        loadFortuneFromCSV()
        
    }
    


    @IBAction func selectMonth(_ sender: UIButton) {
        
        let selectedRow = pickerView.selectedRow(inComponent: 0)
        let selectedMonth = month[selectedRow]
        
        labelTitle.text = "\(name!)님의 \(selectedMonth) 신년운세입니다."
        
        if let fortune = fortuneList.first {
            let monthIndex = month.firstIndex(of: selectedMonth) ?? 0
            labelContent.text = fortune.months[monthIndex]
        } else {
            labelContent.text = "해당 월에 대한 운세 데이터가 없습니다."
        }
        
        //labelContent.isHidden = true
        contentView.isHidden = true
        self.imageView.image = UIImage(named: "roll")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                UIView.transition(with: self.imageView,
                                  duration: 1.5,
                                  options: .transitionCrossDissolve,
                                  animations: {
                                      self.imageView.image = UIImage(named: "back")
                                  }, completion: nil)
            }
        //labelContent.fadeIn()
        contentView.fadeIn()
        

    }
    
    private func parseCSVAt(url: URL) {
        do {
            let data = try Data(contentsOf: url)
            let dataEncoded = String(data: data, encoding: .utf8)
            if let dataArr = dataEncoded?.components(separatedBy: "\n")
                .map({$0.components(separatedBy: ",")}) {
                print("Parsed data: \(dataArr)")
                self.fortuneList = dataArr.compactMap({
                    FortuneModel(value: $0) })
                let fortune = self.fortuneList.randomElement()
                if let fortune = fortune {
                    labelContent.text = "\(fortune.months[0])"
                }
            }
        } catch {
            print("Error reading CSV file")
        }
    }
    
    private func loadFortuneFromCSV() {
        print("loading...")
        let path = Bundle.main.path(forResource: "month", ofType:"csv")!
        parseCSVAt(url: URL(fileURLWithPath: path))
    }
    
    
    struct FortuneModel: Codable {
        var months: [String]
        init?(value: [String]) {
            guard value.count == 12 else { return nil }
            self.months = value
        }
    }

}
