//
//  OperationBaseViewController.swift
//  MemoryCard
//
//  Created by jin fu on 2024/8/19.
//

import UIKit

class OperationBaseViewController: UIViewController {

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask
    {
        return .landscape
    }
    
    override var shouldAutorotate: Bool
    {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
