//
//  ProfileTableViewCell.swift
//  NavigateU
//
//  Created by Faki Doosuur Doris on 12.04.2024.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {
    lazy var iconImage: UIImageView = UIImageView()
    lazy var contentLabel: UILabel = UILabel()
    lazy var arrow: UIImageView = UIImageView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureCell(with profile: Profile) {
        
    }

    private func setupIconImage() {

    }
    private func setupContentlable() {

    }
    private func setupArrow() {
        
    }

}

extension UITableViewCell {
    static var profileReuseIdentifier: String {
        return String(describing: self)
    }
}
