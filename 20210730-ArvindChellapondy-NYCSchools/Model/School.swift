//
//  School.swift
//  20210730-ArvindChellapondy-NYCSchools
//
//  Created by Arvind Chellapondy on 7/30/21.
//

//school struct
struct School : Decodable{
    let dbn: String
    let schoolName : String
    let boro: String?
    let overviewParagraph : String?
    let academicOpportunities1 : String?
    let academicOpportunities2 : String?
    let neighborhood: String?
    let location: String?
    let phoneNumber : String?
    let faxNumber: String?
    let schoolEmail : String?
    let website: String?
    let totalStudents: String?
    let extracurricularActivities : String?
    let schoolSports: String?
    let attendanceRate : String?
    let primaryAddressLine1 : String?
    let city : String?
    let zip : String?
    let stateCode : String?
    let latitude : String?
    let longitude : String?
    let borough : String?
    
    var satStats : SatStats?
    
    //school coding keys
    enum CodingKeys: String, CodingKey {
        case dbn
        case schoolName = "school_name"
        case boro
        case overviewParagraph = "overview_paragraph"
        case academicOpportunities1 = "academicopportunities1"
        case academicOpportunities2 = "academicopportunities2"
        case neighborhood
        case location
        case phoneNumber = "phone_number"
        case faxNumber = "fax_number"
        case schoolEmail = "school_email"
        case website
        case totalStudents = "total_students"
        case extracurricularActivities = "extracurricular_activities"
        case schoolSports = "school_sports"
        case attendanceRate = "attendance_rate"
        case primaryAddressLine1 = "primary_address_line_1"
        case city
        case zip
        case stateCode = "state_code"
        case latitude
        case longitude
        case borough
        
    }
    
    mutating func updateSatStats(satStats : SatStats){
        self.satStats = satStats
    }
}

//school displayable
extension School: Displayable {
    
    var listItems: [(label: String, value: String?)] {
        [("DBN", dbn),
        ("SCHOOL NAME", schoolName),
        ("OVERVIEW", overviewParagraph!),
        ("ADDRESS", [primaryAddressLine1!,city!,stateCode!, zip!].joined(separator:"\n")),
        ("BOROUGH", borough!),
        ("PHONE", phoneNumber!),
        ("FAX", faxNumber!),
        ("EMAIL",schoolEmail ?? "N/A"),
        ("WEBSITE",website!),
        ("ACEDEMIC OPPORTUNITIES",
         [academicOpportunities1 ?? "N/A" ,academicOpportunities2 ?? ""].compactMap{ $0 }.joined(separator:"\n")),
        ("EXTRA-CURRICULAR ACTIVITIES",extracurricularActivities ?? "N/A"),
        ("SCHOOL SPORTS",schoolSports ?? "N/A"),
        ("TOTAL STUDENTS | ATTENDANCE RATE",
         [totalStudents ?? "N/A" , attendanceRate ?? "N/A"].joined(separator: " | ")),
        ("NO. OF SAT TEST TAKERS", satStats?.numberOfTestTakers ?? "N/A"),
        ("AVG. SAT SCORES : READING | MATH | WRITING",  [satStats?.avgCriticalReadingScore ?? "N/A" ,satStats?.avgMathScore ?? "N/A", satStats?.avgWritingScore ?? "N/A"].compactMap{ $0 }.joined(separator:" | "))
        ]
    }

    
}
