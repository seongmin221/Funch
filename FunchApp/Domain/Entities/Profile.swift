//
//  Profile.swift
//  FunchApp
//
//  Created by Geon Woo lee on 1/20/24.
//

import Foundation

struct Profile {
    /// `unique`
    var userCode: String
    /// 유저 닉네임
    var userNickname: String
    /// 생년월일
    var birth: String
    
    /// 직군
    var majors: [Major]
    /// 동아리
    var clubs: [Club]
    /// mbti
    var mbti: String
    /// 별자리
    var bloodType: String
    /// 지하철 역
    var subwayInfos: [SubwayInfo]
    /// 조회수
    var viewerShip: String
    
    /// 전공
    struct Major: Hashable {
        /// 전공 이름
        var name: String
        /// 전공 이미지
        var imageName: String
    }
    
    /// 동아리
    struct Club: Hashable {
        /// 동아리 이름
        var name: String
        /// 동아리 이미지
        var imageName: String
    }
}

extension Profile {
    /// 작업에 있어 테스트 가능한 값 (테스트 코드에 사용하면 안됩니다.)
    static var testableValue: Profile {
        return Profile(
            userCode: "#2X87T",
            userNickname: "넥스터즈다모임",
            birth: "20021225",
            majors: [.init(name: "개발자", imageName: "plus")],
            clubs: [.init(name: "넥스터즈", imageName: "plus")],
            mbti: "ESTP",
            bloodType: "A",
            subwayInfos: [.init(name: "동대문", lines: ["2"])],
            viewerShip: "31"
        )
    }
    
    static var emptyValue: Profile {
        return Profile(
            userCode: "",
            userNickname: "",
            birth: "",
            majors: [],
            clubs: [],
            mbti: "",
            bloodType: "",
            subwayInfos: [],
            viewerShip: ""
        )
    }
}

extension Profile.Major {
    
    static var dummies: [Profile.Major] {
        return [
            .init(name: "개발자", imageName: "plus"),
            .init(name: "디자이너", imageName: "plus"),
        ]
    }
}

extension Profile.Club {
    
    static var dummies: [Profile.Club] {
        return [
            .init(name: "넥스터즈", imageName: "plus"),
            .init(name: "SOPT", imageName: "plus"),
            .init(name: "Depromeet", imageName: "plus"),
        ]
    }
}
