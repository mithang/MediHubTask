//
//  ListTaskCell.swift
//  MediHubTask
//
//  Created by apple on 7/2/18.
//  Copyright © 2018 appledemoobj. All rights reserved.
//

import UIKit

class ListTaskCell: UITableViewCell {

    @IBOutlet weak var lbtitle: UILabel!
    @IBOutlet weak var lbsubtitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configWith(task:Task){
        lbtitle.text=task.title
        lbsubtitle.text="Type: \(task.type.rawValue)"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
