//
//  UserModel.swift
//  Swifty-Companion
//
//  Created by Khomotjo MODIPA on 2018/10/18.
//  Copyright © 2018 Khomotjo. All rights reserved.
//

import Foundation
import JSONParserSwift
import SwiftyJSON

//struct RootClass {
//
//    let id: Int?
//    let email: String?
//    let login: String?
//    let firstName: String?
//    let lastName: String?
//    let url: String?
//    let phone: Any?
//    let displayname: String?
//    let imageUrl: String?
//    let staff: Bool?
//    let correctionPoint: Int?
//    let poolMonth: String?
//    let poolYear: String?
//    let location: Any?
//    let wallet: Int?
//    let groups: [Any]?
//    let cursusUsers: [CursusUsers]?
//    let projectsUsers: [ProjectsUsers]?
//    let languagesUsers: [LanguagesUsers]?
//    let achievements: [Any]?
//    let titles: [Any]?
//    let titlesUsers: [Any]?
//    let partnerships: [Any]?
//    let patroned: [Any]?
//    let patroning: [Any]?
//    let expertisesUsers: [Any]?
//    let campus: [Campus]?
//    let campusUsers: [CampusUsers]?
//
//}
//struct CursusUsers {
//
//    let grade: Any?
//    let level: Double?
//    let skills: [Skills]?
//    let id: Int?
//    let beginAt: String?
//    let endAt: Any?
//    let cursusId: Int?
//    let hasCoalition: Bool?
//    let user: User?
//    let cursus: Cursus?
//
//}
//
//struct Skills {
//
//    let id: Int?
//    let name: String?
//    let level: Double?
//
//}
//
//struct User {
//
//    let id: Int?
//    let login: String?
//    let url: String?
//
//}
//
//struct Cursus {
//
//    let id: Int?
//    let createdAt: String?
//    let name: String?
//    let slug: String?
//
//}
//
//struct ProjectsUsers {
//
//    let id: Int?
//    let occurrence: Int?
//    let finalMark: Int?
//    let status: String?
//    let validated: Bool?
//    let currentTeamId: Int?
//    let project: Project?
//    let cursusIds: [Int]?
//    let markedAt: String?
//    let marked: Bool?
//
//}
//
//struct Project {
//
//    let id: Int?
//    let name: String?
//    let slug: String?
//    let parentId: Int?
//
//}
//
//struct LanguagesUsers {
//
//    let id: Int?
//    let languageId: Int?
//    let userId: Int?
//    let position: Int?
//    let createdAt: String?
//
//}
//
//struct Campus {
//
//    let id: Int?
//    let name: String?
//    let timeZone: String?
//    let language: Language?
//    let usersCount: Int?
//    let vogsphereId: Int?
//    let country: String?
//    let address: String?
//    let zip: String?
//    let city: String?
//    let website: String?
//    let facebook: String?
//    let twitter: String?
//
//}
//
//struct Language {
//
//    let id: Int?
//    let name: String?
//    let identifier: String?
//    let createdAt: String?
//    let updatedAt: String?
//
//}
//
//struct CampusUsers {
//
//    let id: Int?
//    let userId: Int?
//    let campusId: Int?
//    let isPrimary: Bool?
//
//}

struct BaseResponse {
    /* The Properties */
    var image_url: String = ""
    var displayname: String = ""
    var login: String = ""
    var phone: Any?
    var wallet: Int = 0
    var correction_point: Int = 0
    var cursus_users: [Cursus_users]?
    var projects_users: [Projects_users]?
    
    init() {
        
    }
    
    init(_ json: JSON) {
        image_url = json["image_url"].stringValue
        displayname = json["displayname"].stringValue
        login = json["login"].stringValue
        phone = json["phone"]
        wallet = json["wallet"].intValue
        correction_point = json["correction_point"].intValue
        cursus_users = json["cursus_users"].arrayValue.map { Cursus_users($0) }
        projects_users = json["projects_users"].arrayValue.map { Projects_users($0)}
    }

}

/* Objects */
struct Cursus_users {
    var level: Double = 0.0
    var skills: [Skills]?
    
    init(_ json: JSON) {
        level = json["level"].doubleValue
        skills = json["skills"].arrayValue.map { Skills($0) }
    }
}

struct Skills {
    var name: String = ""
    var level: Double = 0.0
    
    init(_ json: JSON) {
        name = json["name"].stringValue
        level = json["level"].doubleValue
    }
}

struct Projects_users {
    var final_mark: Int = 0
    var project: Project?
    
    init(_ json: JSON) {
        final_mark = json["final_mark"].intValue
        project = Project(json["project"])
    }
}

struct Project {
    var name: String = ""
    
    init(_ json: JSON) {
        name = json["name"].stringValue
    }
}
