//
//  MyCell.swift
//  ExpandTableView
//
//  Created by 季 雲 on 2017/11/09.
//  Copyright © 2017 Ericji. All rights reserved.
//

import UIKit

class MyCell: UITableViewCell {
    
    private(set) var expanded = false
    private let headerView = UIView()
    private let headerTitle = UILabel()
    private let footView = UIView()
    private let footTitle = UILabel()
    private let detailView = UIView()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.backgroundColor = UIColor.white
        headerView.backgroundColor = UIColor.red
        self.contentView.addSubview(headerView)
        headerView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(40)
        }
        
        footView.backgroundColor = UIColor.black
        self.contentView.addSubview(footView)
        footView.snp.makeConstraints { (make) in
            make.bottom.left.right.equalToSuperview()
            make.height.equalTo(40)
        }
        
        detailView.backgroundColor = UIColor.yellow
        self.contentView.addSubview(detailView)
        detailView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(headerView.snp.bottom)
            make.bottom.equalTo(footView.snp.top)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setExpanded(_ expanded: Bool) {
        self.expanded = expanded
        toggleCell()
    }

    private func toggleCell() {
//        detailView.isHidden = !expanded
//        arrow.transform = expanded ? CGAffineTransform(rotationAngle: CGFloat.pi) : .identity
    }
    

}
