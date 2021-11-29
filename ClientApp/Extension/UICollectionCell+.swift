//
//  UICollectionCell+.swift
//  ClientApp
//
//  Created by Рамазан Юсупов on 9/11/21.
//

import UIKit

extension UIView {
    static func identifier() -> String {
        String(describing: self)
    }
}

extension UICollectionView {
    enum ReusableViewType: String {
        case UICollectionElementKindSectionHeader
        case UICollectionElementKindSectionFooter
    }
    
    func registerReusable<Cell: UICollectionViewCell>(CellType: Cell.Type) {
        register(CellType, forCellWithReuseIdentifier: CellType.identifier())
    }
    
    func dequeueIdentifiableCell<Cell: UICollectionViewCell>(_ type: Cell.Type, for indexPath: IndexPath) -> Cell {
        let reuseId = Cell.identifier()
        guard let cell = dequeueReusableCell(withReuseIdentifier: reuseId, for: indexPath) as? Cell else { fatalError() }
        return cell
    }
    
    func registerReusableView<View: UICollectionReusableView>(ViewType: View.Type, type: ReusableViewType) {
        register(ViewType, forSupplementaryViewOfKind: type.rawValue, withReuseIdentifier: View.identifier())
    }
    
    func dequeuReusableView<View: UICollectionReusableView>(ViewType: View.Type, type: ReusableViewType, for indexPath: IndexPath) -> View {
        let reuseId = View.identifier()
        guard let view = dequeueReusableSupplementaryView(ofKind: type.rawValue,
                                                          withReuseIdentifier: reuseId,
                                                          for: indexPath) as? View
        else { fatalError() }
        return view
    }
}
