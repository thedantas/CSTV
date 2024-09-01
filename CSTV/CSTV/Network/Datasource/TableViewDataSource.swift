//
//  TableViewDataSource.swift
//  CSTV
//
//  Created by André  Costa Dantas on 27/08/24.
//

import Foundation
import UIKit

class TableViewDataSource<CellType, ViewModel>: NSObject, UITableViewDataSource where
    CellType: UITableViewCell,
    CellType: NibLoadableView,
    CellType: ReusableView,
    ViewModel: ListViewModel {

    // MARK: - Properties
    var viewModel: ViewModel
    let configureCell: (CellType, ViewModel.Model) -> Void

    // MARK: - Init
    init(viewModel: ViewModel, tableView: UITableView, configureCell: @escaping (CellType, ViewModel.Model) -> Void) {
        tableView.register(CellType.self)
        tableView.tableFooterView = UIView.init(frame: .zero)
        self.viewModel = viewModel
        self.configureCell = configureCell
    }

    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows(section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CellType = tableView.dequeueReusableCell(forIndexPath: indexPath)

        let model = viewModel.modelAt(indexPath.row)
        self.configureCell(cell, model)

        return cell
    }

}
