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
        let cellId = "BookCell"
        
        // Averiguar cual es el libro
        let tagNamebyIndex = model.tags[indexPath.section]
        var booksbyTag = model.books(forTagName: tagNamebyIndex)
        let book = booksbyTag?[indexPath.row]
        
        // Crear la celda
        var cell = tableView.dequeueReusableCell(withIdentifier: cellId)
        
        if cell == nil {
            // el opcional esta vacio y toca crear la celda desde cero
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellId)
        }
        
        // Configurarla
        let stringImage = book?.imageUrl.absoluteString
        cell?.imageView?.image = UIImage(named: stringImage!)
        cell?.textLabel?.text = book?.title
        cell?.detailTextLabel?.text = book?.authors.description
        
        // Devolverla
        return cell!
    }

}
