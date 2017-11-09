//
//  ViewController.swift
//  ExpandTableView
//
//  Created by 季 雲 on 2017/11/09.
//  Copyright © 2017 Ericji. All rights reserved.
//

import UIKit
import SnapKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    private let tableView = UITableView()
    
    var expandedIndexPaths = [IndexPath]()
    var shouldAnimateCellToggle = true
    var shouldScrollIfNeededAfterCellExpand = true
    var datasource: [MyModel] = []
    
    // MARK: Actions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.allowsSelection = true
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 44
        tableView.separatorStyle = .none
        tableView.register(MyCell.classForCoder(), forCellReuseIdentifier: "MyCell")
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        let model1 = MyModel()
        model1.title = "one"
        model1.msg = "i am coming"
        
        let model2 = MyModel()
        model2.title = "two"
        model2.msg = "i will go"
        
        self.datasource.append(model1)
        self.datasource.append(model2)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func toggleCell(_ cell: MyCell, animated: Bool) {
        if cell.expanded {
            collapseCell(cell, animated: animated)
        } else {
            expandCell(cell, animated: animated)
        }
    }
    
    
    // MARK: UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath)
        cell.selectionStyle = .none
        return cell
    }
    
    // MARK: UITableViewDelegate
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return expandedIndexPaths.contains(indexPath) ? 200.0 : 80.0
    }
    
    func tableView(_ tableView: UITableView,
                                 willDisplay cell: UITableViewCell,
                                 forRowAt indexPath: IndexPath) {
        if let cell = cell as? MyCell {
            let expanded = expandedIndexPaths.contains(indexPath)
            cell.setExpanded(expanded)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? MyCell {
            toggleCell(cell, animated: shouldAnimateCellToggle)
        }
    }
    
    // expand
    private func expandCell(_ cell: MyCell, animated: Bool) {
        if let indexPath = tableView.indexPath(for: cell) {
            tableView.beginUpdates()
            addToExpandedIndexPaths(indexPath)
            cell.setExpanded(true)
            self.scrollIfNeededAfterExpandingCell(at: indexPath)
            tableView.endUpdates()
        }
    }
    
    private func collapseCell(_ cell: MyCell, animated: Bool) {
        if let indexPath = tableView.indexPath(for: cell) {
            self.tableView.beginUpdates()
            cell.setExpanded(false)
            self.removeFromExpandedIndexPaths(indexPath)
            self.tableView.endUpdates()
        }
    }
    
    private func addToExpandedIndexPaths(_ indexPath: IndexPath) {
        expandedIndexPaths.append(indexPath)
    }
    
    private func removeFromExpandedIndexPaths(_ indexPath: IndexPath) {
        if let index = expandedIndexPaths.index(of: indexPath) {
            expandedIndexPaths.remove(at: index)
        }
    }
    
    private func scrollIfNeededAfterExpandingCell(at indexPath: IndexPath) {
        guard shouldScrollIfNeededAfterCellExpand,
            let cell = tableView.cellForRow(at: indexPath) as? MyCell else {
                return
        }
        let cellRect = tableView.rectForRow(at: indexPath)
        let isCompletelyVisible = tableView.bounds.contains(cellRect)
        if cell.expanded && !isCompletelyVisible {
            tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
        }
    }


}

