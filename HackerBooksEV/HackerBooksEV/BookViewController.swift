//
//  BookViewController.swift
//  HackerBooksEV
//
//  Created by usuario on 2/4/17.
//  Copyright © 2017 evizcloud. All rights reserved.
//

import UIKit

class BookViewController: UIViewController {

    // MARK: - Properties
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var photoView: UIImageView!
    
    let model: Book
    
    
    // MARK: - Initialization
    
    init (model: Book) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
        syncViewWithModel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        syncViewWithModel()
    }
    
    // MARK: - Sync model -> View
    func syncViewWithModel() {
        title = model.title
        titleLabel.text = model.title
        //photoView.image = model.imageUrl
    }
    
    // MARK: - Actions
    
    @IBAction func readPDF(_ sender: Any) {
    }
    
    
    @IBAction func checkFavourite(_ sender: Any) {
    }

}
