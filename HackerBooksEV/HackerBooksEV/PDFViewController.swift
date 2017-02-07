//
//  PDFViewController.swift
//  HackerBooksEV
//
//  Created by usuario on 2/7/17.
//  Copyright © 2017 evizcloud. All rights reserved.
//

import UIKit

class PDFViewController: UIViewController {
    
    var model : Book?
    var bookObserver : NSObjectProtocol?
    
    @IBOutlet weak var browserView: UIWebView!
    
    init(model: Book) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
        title = model.title
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNotifications()
        
        browserView.load((model?.pdfUrl.data)!, mimeType: "application/pdf", textEncodingName: "utf8", baseURL: URL(string:"http://www.google.com")!)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tearDownNotifications()
    }
}

//MARK: - Notifications
extension PDFViewController{
    
    func setupNotifications(){
        
        let nc = NotificationCenter.default
        bookObserver = nc.addObserver(forName: BookPDFDidDownload, object: model, queue: nil){ (n: Notification) in
            
            self.browserView.load((self.model?.pdfUrl.data)!, mimeType: "application/pdf", textEncodingName: "utf8", baseURL: URL(string:"http://www.google.com")!)
            
        }
    }
    
    func tearDownNotifications(){
        
        let nc = NotificationCenter.default
        nc.removeObserver(bookObserver)
        bookObserver = nil
    }
}
