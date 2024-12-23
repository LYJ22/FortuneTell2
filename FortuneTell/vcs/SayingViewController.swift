//
//  SayingViewController.swift
//  FortuneTell
//
//  Created by 22 on 12/23/24.
//

import UIKit

extension UIView {
    public func fadeInWithFlip(duration: TimeInterval = 2.0, delay: TimeInterval = 0.5, completion: ((Bool) -> Void)? = nil) {
        self.alpha = 0.0
        self.isHidden = false
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            UIView.transition(with: self, duration: duration, options: [.transitionCurlDown], animations: {
                self.alpha = 1.0
            }, completion: completion)
        }
    }
}

class SayingViewController: UIViewController {
    @IBOutlet weak var labelContent: UILabel!
    
    @IBOutlet weak var labelPeople: UILabel!
    
    @IBOutlet weak var viewBack: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewBack.isHidden = true

        labelContent.font = UIFont(name: "NotoSerifKR-Medium", size: 22)
        labelPeople.font = UIFont(name: "NotoSerifKR-Medium", size: 18)
        loadSayingCSV()
        viewBack.fadeInWithFlip()
        
    }
    
    private func parseCSVAt(url: URL){
        do {
            let data = try Data(contentsOf: url)
            let dataEncoded = String(data: data, encoding: .utf8)
            if var dataArr = dataEncoded?.components(separatedBy: "\n").map({$0.components(separatedBy: ",")}){
                dataArr.removeLast()
                let saying = dataArr.randomElement()
                
                if let saying = saying {
                    labelContent.text = "\"\(saying[0])\""
                    labelPeople.text = "\(saying[1])"
                }
                
            }
        } catch{
            print("Error reading CSV")
        }
    }
    
    private func loadSayingCSV(){
        print("loading")
        let path = Bundle.main.path(forResource: "saying", ofType: "csv")!
        
        parseCSVAt(url: URL(fileURLWithPath: path))
    }
    

   
}
