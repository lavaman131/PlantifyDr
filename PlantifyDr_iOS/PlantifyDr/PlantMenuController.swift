//
//  PlantMenuController.swift
//  PlantifyDr
//
//  Created by Ali Lavaee on 2/21/21.
//  Copyright © 2021 Swift Creator. All rights reserved.
//

import UIKit

class PlantMenuController: UIViewController {
    
    var plants = ["Apple","Bell pepper","Cherry","Citrus","Corn","Grape","Peach","Potato","Strawberry","Tomato"]
    
    let myImages = [UIImage(named:"apple")!,
            UIImage(named:"bell_pepper")!,
            UIImage(named:"cherry")!, UIImage(named:"citrus")!, UIImage(named:"corn")!,UIImage(named:"grape")!,UIImage(named:"peach")!,UIImage(named:"potato")!,UIImage(named:"strawberry")!,UIImage(named:"tomato")!]
    
    @IBOutlet weak var plantTableView: UITableView!
    
    // make list of all plants
    
    // each item = object -> name, path
    
    // make var that transfers to second screen
    
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        plantTableView.delegate = self
        
        plantTableView.dataSource = self
        
        plantTableView.separatorStyle = .none
        plantTableView.showsVerticalScrollIndicator = true
        
    }

        
}

extension PlantMenuController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return plants.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = plantTableView.dequeueReusableCell(withIdentifier: "plantCell") as! PlantTVC
        let plant = plants[indexPath.row]
        cell.plantLbl.text = plant
        cell.plantImgView.image = myImages[indexPath.row]
        
        cell.plantView.layer.cornerRadius = cell.plantView.frame.height / 2
        
        cell.plantImgView.layer.cornerRadius = cell.plantImgView.frame.height / 2
        
        cell.plantButton.tag = indexPath.row
        cell.plantButton.addTarget(self, action: #selector(viewdetail), for: .touchUpInside)
        
        return cell
    }
    
        @objc func viewdetail(sender: UIButton)
        {
            let vc = storyboard?.instantiateViewController(withIdentifier: "pred_vc") as! PredictionViewController
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true)
    
        }
    
    
}


    
    

