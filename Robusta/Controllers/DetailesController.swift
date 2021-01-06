//
//  DetailesController.swift
//  Robusta
//
//  Created by gamal on 12/22/20.
//

import UIKit

class DetailesController: UIViewController {
    var data : Data?
    var repoName : String?
    var owner : String?
    
    @IBOutlet weak var avaatarIMG: UIImageView!
    @IBOutlet weak var repo : UILabel!
    @IBOutlet weak var ownerName: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        avaatarIMG.layer.cornerRadius = avaatarIMG.frame.width / 2
        avaatarIMG.image = UIImage(data: data!)
        repo.text = repoName
        ownerName.text = owner
    }
}
