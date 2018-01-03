//
//  SettingsViewController.swift
//  tippy
//
//  Created by Farid Ramos on 1/2/18.
//  Copyright © 2018 Farid Ramos. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    @IBOutlet weak var defaultTips: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "Tip Calculator"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let defaultSettings = UserDefaults.standard
        if(defaultSettings.object(forKey: "defaultTip") != nil) {
            let index = defaultSettings.integer(forKey: "defaultTip")
            defaultTips.selectedSegmentIndex = index
        }
        
    }
    @IBAction func defaultTipChanged(_ sender: Any) {
        let defaultSettings = UserDefaults.standard
        defaultSettings.set(defaultTips.selectedSegmentIndex, forKey: "defaultTip")
        defaultSettings.synchronize()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
