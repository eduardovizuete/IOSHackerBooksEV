//
//  BookViewController.swift
//  HackerBooksEV
//
//  Created by usuario on 2/4/17.
//  Copyright © 2017 evizcloud. All rights reserved.
//

import UIKit

class BookViewController: UIViewController {

    let model: Book
    
    init (model: Book) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    

}
