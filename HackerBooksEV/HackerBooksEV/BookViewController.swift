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
    
    var model: Book
    
    //MARK: - Outlets
    
    @IBOutlet weak var photoView: UIImageView!
    @IBOutlet weak var favoriteItem: UIBarButtonItem!
    
    // MARK: - Initialization
    
    init (model: Book) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Sync model -> View
    func syncViewWithModel() {
        title = model.title
        
        if model.isFavorite{
            favoriteItem.title = "★"
        }else{
            favoriteItem.title = "☆"
        }
        
        photoView.image = UIImage(data: model.imageUrl.data)
    }
    
    // MARK: - Actions
    
    @IBAction func readPDF(_ sender: Any) {
        
        let pdfVC = PDFViewController(model: model)
        navigationController?.pushViewController(pdfVC, animated: true)
        
    }
    
    
    @IBAction func checkFavourite(_ sender: Any) {
        model.isFavorite = !model.isFavorite
    }
    
    //MARK: - LifeCycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        startObserving(book: model)
        syncViewWithModel()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        stopObserving(book: model)
    }
    
    //MARK: - Notifications
    let nc = NotificationCenter.default
    var bookObserver : NSObjectProtocol?
    
    func startObserving(book: Book){
        bookObserver = nc.addObserver(forName: BookDidChange, object: book, queue: nil){ (n: Notification) in
            self.syncViewWithModel()
        }
    }
    
    func stopObserving(book:Book){
        nc.removeObserver(bookObserver)
    }


}

extension BookViewController: LibraryTableViewControllerDelegate{
    
    func libraryTableViewController(_ sender: LibraryTableViewController, didSelect selectedBook:Book)
    {
        stopObserving(book: model)
        model = selectedBook
        startObserving(book: selectedBook)
        
    }
}

