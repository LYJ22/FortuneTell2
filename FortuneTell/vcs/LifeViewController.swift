//
//  TodayViewController.swift
//  FortuneTell
//
//  Created by 22 on 12/19/24.
//

import UIKit

class LifeViewController: UIViewController {
    var fortuneList: [FortuneModel] = []
    var name: String?
    var gender: String?
    var dateType: String?
    var date: String?
    var time: String?
    @IBOutlet weak var subTitle: UITextField!
    @IBOutlet weak var laterLabel: UILabel!
    @IBOutlet weak var middleLabel: UILabel!
    @IBOutlet weak var earlyLabel: UILabel!
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
        self.subTitle.text = "\(name!)님의 평생운세입니다."
        // 탭바 아이템의 이미지 색상 변경 방지
        if let tabBarItems = tabBarController?.tabBar.items {
            for item in tabBarItems {
                item.image = item.image?.withRenderingMode(.alwaysOriginal)
            }
        }
        
        loadFortuneFromCSV()
    
    }
    
    private func parseCSVAt(url: URL) {
        do {
            let data = try Data(contentsOf: url)
            let dataEncoded = String(data: data, encoding: .utf8)
            if let dataArr = dataEncoded?.components(separatedBy: "\n").map({$0.components(separatedBy: ",")}) {
                print("Parsed data: \(dataArr)")
                self.fortuneList = dataArr.compactMap({ FortuneModel(value: $0) })
                
                let fortune = self.fortuneList.randomElement()
                
                if let fortune = fortune {
                    earlyLabel.text = fortune.earlyLife
                    middleLabel.text = fortune.middleLife
                    laterLabel.text = fortune.laterLife
                }
                
            }
        } catch {
            print("Error reading CSV file")
        }
    }
    
    private func loadFortuneFromCSV() {
        print("loading...")
        let path = Bundle.main.path(forResource: "life", ofType: "csv")!
        parseCSVAt(url: URL(fileURLWithPath: path))
    }
    
    struct FortuneModel: Codable {
        var earlyLife: String
        var middleLife: String
        var laterLife: String
        
        init?(value: [String]) {
            guard value.count == 3 else { return nil }
            earlyLife = value[0]
            middleLife = value[1]
            laterLife = value[2]
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
