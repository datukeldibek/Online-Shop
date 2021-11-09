//
//  UICollectionCell+.swift
//  ClientApp
//
//  Created by Рамазан Юсупов on 9/11/21.
//

import UIKit

extension UICollectionViewCell {
    static func identifier() -> String {
        String(describing: self)
    }
}

extension UICollectionView {
    func registerReusable<Cell: UICollectionViewCell>(CellType: Cell.Type) {
        register(CellType, forCellWithReuseIdentifier: CellType.identifier())
    }
    
    func dequeueIdentifiableCell<Cell: UICollectionViewCell>(_ type: Cell.Type, for indexPath: IndexPath) -> Cell {
        let reuseId = Cell.identifier()
        guard let cell = dequeueReusableCell(withReuseIdentifier: reuseId, for: indexPath) as? Cell else { fatalError() }
        return cell
    }
}
