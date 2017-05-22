import UIKit
import Foundation

class GeneralDataSource<CellType: UIView, ItemType>: NSObject, UITableViewDataSource, UICollectionViewDataSource {
    var items: [[ItemType]]
    var cellReuseIdentifier: String
    var configureClosure: (CellType, ItemType) -> Void

    init(items: [[ItemType]], cellReuseIdentifier: String, configureClosure: @escaping (CellType, ItemType) -> Void) {
        self.items = items
        self.cellReuseIdentifier = cellReuseIdentifier
        self.configureClosure = configureClosure
        super.init()
    }

    func itemAtIndexPath(indexPath: IndexPath) -> ItemType {
        return self.items[indexPath.section][indexPath.row] as ItemType
    }

    func configureCell(cell: CellType, atIndexPath indexPath: IndexPath) {
        let item = itemAtIndexPath(indexPath: indexPath)
        self.configureClosure(cell, item)
    }

    // MARK: UITableViewDataSource
    func numberOfSectionsInTableView(tableView: UITableView!) -> Int {
        if items.count <= 0 {
            return 0
        }

        return items.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items[section].count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellReuseIdentifier, for: indexPath) as! CellType
                configureCell(cell: cell, atIndexPath: indexPath)
                return cell as! UITableViewCell
    }
    // MARK: - UICollectionViewDataSource

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items[section].count
    }

    func numberOfSectionsInCollectionView(collectionView: UICollectionView!) -> Int {
        if items.count <= 0 {
            return 0
        }

        return items.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseIdentifier, for: indexPath as IndexPath) as! CellType
        configureCell(cell: cell, atIndexPath: indexPath)

        return cell as! UICollectionViewCell
    }
}
