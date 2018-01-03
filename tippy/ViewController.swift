//
//  ViewController.swift
//  tippy
//
//  Created by Farid Ramos on 10/25/17.
//  Copyright © 2017 Farid Ramos. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tipLbl: UILabel!
    @IBOutlet weak var totalLbl: UILabel!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipCtrl: UISegmentedControl!
    @IBOutlet weak var twoPpl: UILabel!
    @IBOutlet weak var threePpl: UILabel!
    @IBOutlet weak var fourPpl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        billField!.becomeFirstResponder()
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale.autoupdatingCurrent

        
        let defaultSettings = UserDefaults.standard
        
        if(defaultSettings.object(forKey: "billAmt") != nil) {
            let timer = defaultSettings.object(forKey: "timeClosed")!
            if(NSDate().timeIntervalSinceReferenceDate - (timer as! NSDate).timeIntervalSinceReferenceDate < 60 * 10) {
                billField.text = defaultSettings.string(forKey: "billAmt")
            }
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        var tipIndex = 0
        
        let defaultSettings = UserDefaults.standard
        if(defaultSettings.object(forKey: "defaultTip") != nil) {
            tipIndex = defaultSettings.integer(forKey: "defaultTip")
        }
        
        tipCtrl.selectedSegmentIndex = tipIndex
        updateTip(tipPrctIndex: tipIndex)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        let defaultSettings = UserDefaults.standard
        defaultSettings.set(billField.text, forKey: "billAmt")
        defaultSettings.set(NSDate(), forKey: "timeClosed")
        defaultSettings.synchronize()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onTap(_ sender: Any) {
        view.endEditing(true)
    }
    
    @IBAction func calcTip(_ sender: Any) {
        updateTip(tipPrctIndex: tipCtrl.selectedSegmentIndex)
    }
    
    func updateTip(tipPrctIndex: Int) {
        let format = NumberFormatter()
        format.numberStyle = .currency
        
        
        let tipPercent = [0.15, 0.2, 0.25]
        
        let bill = Double(billField.text!) ?? 0
        let tip = bill * tipPercent[tipPrctIndex]
        let total = bill + tip
        let total2 = total / 2
        let total3 = total / 3
        let total4 = total / 4
        
        tipLbl.text = format.string(from: tip as NSNumber)
        totalLbl.text = format.string(from: total as NSNumber)
        twoPpl.text = format.string(from: total2 as NSNumber)
        threePpl.text = format.string(from: total3 as NSNumber)
        fourPpl.text = format.string(from: total4 as NSNumber)
    }
    
}

