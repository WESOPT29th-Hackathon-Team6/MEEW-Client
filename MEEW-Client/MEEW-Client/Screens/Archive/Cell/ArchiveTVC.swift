//
//  ArchiveTVC.swift
//  MEEW-Client
//
//  Created by taekki on 2022/08/18.
//

import UIKit

import SnapKit
import Then
import Kingfisher

final class ArchiveTVC: UITableViewCell {
    
    private lazy var characterImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.image = ImageLiterals.imageCharacterToday
    }

    private let progressView = ArchiveLevelProgressView()
    
    private let characterNameLabel = UILabel().then {
        $0.text = "캐릭터 이름입니다."
        $0.textColor = .white
        $0.font = .body1
    }
    
    private let timeLabel = UILabel().then {
        $0.text = "YYYY.MM.DD"
        $0.textColor = .grey400
        $0.font = UIFont(name: "SpoqaHanSansNeo-Medium", size: 10.0)!
    }
    
    private let lineView = UIView().then {
        $0.backgroundColor = .grey500
    }
    
    private lazy var dateFormatter = DateFormatter().then {
        $0.dateFormat = "YYYY.MM.dd"
        $0.locale = Locale(identifier: "ko_KR")
        $0.timeZone = TimeZone(identifier: "ko_KR")
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        configureUI()
        configureLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    // MARK: - Configure Functions
    
    func configureUI() {
        backgroundColor = .clear
        selectionStyle = .none
        progressView.layer.cornerRadius = 8
    }

    func configureLayout() {
        contentView.addSubviews([characterImageView, progressView, characterNameLabel, timeLabel, lineView])
        
        characterImageView.snp.makeConstraints {
            $0.width.height.equalTo(100)
            $0.leading.equalToSuperview().inset(25)
            $0.top.equalToSuperview().inset(10)
        }
        
        progressView.snp.makeConstraints {
            $0.leading.equalTo(characterImageView.snp.trailing).offset(10)
            $0.top.equalToSuperview().inset(50)
            $0.width.equalTo(88)
            $0.height.equalTo(22)
        }
        
        characterNameLabel.snp.makeConstraints {
            $0.top.equalTo(progressView.snp.bottom).offset(8)
            $0.leading.equalTo(progressView)
        }
        
        timeLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(8)
            $0.trailing.equalToSuperview().inset(27)
        }
        
        lineView.snp.makeConstraints {
            $0.top.equalTo(characterImageView.snp.bottom).offset(12)
            $0.height.equalTo(0.5)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.lessThanOrEqualToSuperview()
        }
    }
    
    func configure(_ data: Recent?) {
        let df = DateFormatter()
        df.dateFormat = "YYYY-MM-dd'T'hh:mm:ss.sss'Z'"
        guard let date = df.date(from: data?.date ?? "") else { return }
        guard let imgURL = data?.imgURL else { return }

        characterNameLabel.text = data?.name
        timeLabel.text = dateFormatter.string(from: date)
        characterImageView.kf.setImage(with: URL(string: imgURL))
    }
    
    func configure(withAll data: All?) {
        let df = DateFormatter()
        df.dateFormat = "YYYY-MM-dd'T'hh:mm:ss.sss'Z'"
        guard let date = df.date(from: data?.date ?? "") else { return }
        guard let imgURL = data?.imgURL else { return }

        characterNameLabel.text = data?.name
        timeLabel.text = dateFormatter.string(from: date)
        characterImageView.kf.setImage(with: URL(string: imgURL))
    }
}