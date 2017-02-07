//
//  BookTableViewCell.swift
//  HackerBooksEV
//
//  Created by usuario on 2/4/17.
//  Copyright © 2017 evizcloud. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {
    
    var titleLabel      : UILabel = UILabel()
    var authorsLabel    : UILabel = UILabel()
    var tagsLabel       : UILabel = UILabel()
    
    var book: Book? {
        didSet {
            if let b = book {
                titleLabel.text = b.title
                authorsLabel.text = b.authors.description
                tagsLabel.text = b.tags.description
                setNeedsLayout()
            }
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
                
        titleLabel.textAlignment = .left
        titleLabel.textColor = UIColor.black
        contentView.addSubview(titleLabel)
        
        authorsLabel.textAlignment = .left
        contentView.addSubview(authorsLabel)
        
        tagsLabel.textAlignment = .left
        contentView.addSubview(tagsLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        //titleLabel = UILabel(frame: CGRect(x: 20, y: 20, width: 200, height: 20))
        //authorsLabel = UILabel(frame: CGRect(x: 20, y: 20, width: 200, height: 20))
        //tagsLabel = UILabel(frame: CGRect(x: 20, y: 20, width: 200, height: 20))
    }

}
