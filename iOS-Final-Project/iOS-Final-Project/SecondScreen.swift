//
//  SecondScreen.swift
//  iOS-Final-Project
//
//  Created by Vishwajeet Pandey on 17/05/22.
//

import UIKit

class SecondScreen: UIViewController,UITableViewDelegate, UITableViewDataSource {
   
    

    @IBOutlet weak var table1: UITableView!
    
    @IBOutlet weak var iv1: UIImageView!

    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    
    
    var section1Names : [String] = []
    var section1Images : [String] = []
    var section1URLS : [String] = []
    
    var section2Names : [String] = []
    var section2Images : [String] = []
    var section2URLS : [String] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        section1Names = ["INDIGO AIRLINES", "GO AIR"]
        section1Images = ["indigo.png", "go air.jpeg"]
        section1URLS = ["https://www.goindigo.in","https://www.flygofirst.com/"]
        
        
        
        section2Names = ["IRCTC", "YATRA"]
        section2Images = ["irctc.jpeg","yatra.png" ]
        section2URLS = ["https://www.irctc.co.in/nget/train-search","https://www.yatra.com/"]
        
        table1.delegate = self
        table1.dataSource = self


        // Do any additional setup after loading the view.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return section1Names.count
        }
            
        else{
            return section2Names.count
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0{
            return "Airways"
        }
        else{
            return "Railways"
        }
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        if section == 0{
            return "Airways END"
        }
            
        else{
            return "Railways END"
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0{
            
//        creating cells
            let cell = tableView.dequeueReusableCell(withIdentifier: "identifier1", for: indexPath)
            
            //Display the data in cells
            
            cell.textLabel?.text = section1Names[indexPath.row]
//            cell.imageView?.image = UIImage(named: section1Images[indexPath.row])
            cell.accessoryType = .disclosureIndicator
            cell.backgroundColor = .white
            
            return cell
        }
        
        else {
           
            //        creating cells
            let cell = tableView.dequeueReusableCell(withIdentifier: "identifier1", for: indexPath)
            
            //Display the data in cells
            
            cell.textLabel?.text = section2Names[indexPath.row]
//            cell.imageView?.image = UIImage(named: section2Images[indexPath.row])
            cell.accessoryType = .detailDisclosureButton
            cell.backgroundColor = .white
            
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0{
            label1.text = section1Names[indexPath.row]
            label2.text = section1URLS[indexPath.row]
            iv1.image = UIImage(named: section1Images[indexPath.row])
        }
        else{
            label1.text = section2Names[indexPath.row]
            label2.text = section2URLS[indexPath.row]
            iv1.image = UIImage(named: section2Images[indexPath.row])
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let nextscreen = segue.destination as! ThirdScreen
        nextscreen.string1 = label1.text
        nextscreen.string2 = label2.text
        
        
    }
    

  

}
