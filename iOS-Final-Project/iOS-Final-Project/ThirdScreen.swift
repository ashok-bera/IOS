//
//  ThirdScreen.swift
//  iOS-Final-Project
//
//  Created by Vishwajeet Pandey on 18/05/22.
//

import UIKit
import WebKit

class ThirdScreen: UIViewController {
    
    

    @IBOutlet weak var wv1: WKWebView!
    var url1:URL!
    var request1:URLRequest!
    @IBOutlet weak var bar1: UIBarButtonItem!
    
    var string1: String!
    var string2: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.title = string1
        
        url1=URL(string: string2)
        request1=URLRequest(url: url1)
        wv1.load(request1)
    }
    @IBAction func barClick(_ sender: UIBarButtonItem) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    

 

}
