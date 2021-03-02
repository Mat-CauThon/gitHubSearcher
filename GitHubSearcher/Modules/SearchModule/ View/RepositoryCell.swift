//
//  RepositoryCell.swift
//  GitHubSearcher
//
//  Created by Roman Mishchenko on 02.03.2021.
//

import UIKit

class RepositoryCell: UITableViewCell {
    
    private let fullNameLabel : UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        label.adjustsFontSizeToFitWidth = false
        return label
    }()
    
    private let starsLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addSubview(self.fullNameLabel)
        self.addSubview(self.starsLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setup(fullName: String, starsCount: Int) {
        self.fullNameLabel.text = fullName
        self.starsLabel.text = STR.Search.starsCount.replacingOccurrences(of: "%", with: String(starsCount))
        self.fullNameLabel.snp.makeConstraints {
            $0.left.equalToSuperview().offset(Design.Spacing.d12)
            $0.top.bottom.equalToSuperview()
            $0.width.equalTo(260)
            $0.height.equalTo(40).priority(.medium)
        }
        self.starsLabel.snp.makeConstraints {
            $0.right.equalToSuperview().inset(Design.Spacing.d12)
            $0.top.bottom.equalToSuperview()
        }
    }
}
