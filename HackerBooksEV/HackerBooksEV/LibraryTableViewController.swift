//
//  LibraryTableViewController.swift
//  HackerBooksEV
//
//  Created by usuario on 2/3/17.
//  Copyright © 2017 evizcloud. All rights reserved.
//

import UIKit

class LibraryTableViewController: UITableViewController {
    
    //MARK: - Properties
    
    let model: Library
    
    // MARK: - Initialization
    
    init(model: Library) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        //tableView.register(BookTableViewCell.self, forCellReuseIdentifier: "cell")
        //tableView.register(BTableViewCell.self, forCellReuseIdentifier: "CellBook")
    }
    
    // MARK: - Table View Delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Averiguar cual es el libro
        let tagNamebyIndex = model.tags[indexPath.section]
        var booksbyTag = model.books(forTagName: tagNamebyIndex)
        let book = booksbyTag?[indexPath.row]
        
        // Crear un BookVC
        let bookVC = BookViewController(model: book!)
        
        // push
        self.navigationController?.pushViewController(bookVC, animated: true)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return model.tags.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        let tagNamebyIndex = model.tags[section]
        
        return model.bookCount(forTagName: tagNamebyIndex)
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let tagNamebyIndex = model.tags[section]
        
        return tagNamebyIndex.name
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Definir un id para el tipo de celda
        let cellId = "CellBook"
        
        // Averiguar cual es el libro
        let tagNamebyIndex = model.tags[indexPath.section]
        var booksbyTag = model.books(forTagName: tagNamebyIndex)
        let book = booksbyTag?[indexPath.row]
        
        // Crear la celda
        var cell = tableView.dequeueReusableCell(withIdentifier: cellId)
        //var cell = tableView.dequeueReusableCell(withIdentifier: cellId) as? BTableViewCell
        
        
        if cell == nil {
            // el opcional esta vacio y toca crear la celda desde cero
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellId)
            //cell = BTableViewCell.init(style: .subtitle, reuseIdentifier: cellId)
        }
    
        
        // Configurarla
        //let stringImage = book?.imageUrl.absoluteString
        //cell?.imageView?.image = UIImage(named: stringImage!)
        
        cell?.imageView?.image = UIImage(data: (book?.imageUrl.data)!)
        cell?.textLabel?.text = book?.title
        cell?.detailTextLabel?.text = book?.authors.description
        
        //cell?.book = book
        
        // Devolverla
        return cell!
    }
    

}

//MARK: - Delegate protocol
protocol LibraryTableViewControllerDelegate {
    func libraryTableViewController(_ sender: LibraryTableViewController, didSelect selectedBook:Book)
}

