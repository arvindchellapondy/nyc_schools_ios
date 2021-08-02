//
//  SchoolsListPresenter.swift
//  20210730-ArvindChellapondy-NYCSchools
//
//  Created by Arvind Chellapondy on 7/30/21.
//

import Foundation

//schools list view delegate
protocol SchoolsListViewDelegate : NSObjectProtocol {
    func onUpdateSchoolsList(schools: [School])
}

//schools list presenter
class SchoolsListPresenter {
    
    private let nycSchoolsService : NycSchoolsService
    weak private var schoolsListViewDelegate : SchoolsListViewDelegate?
    
    var schools: [School] = []
    var satStats: [SatStats] = []
    var schoolDisplayable : [Displayable] = []
    
    init(nycSchoolsService : NycSchoolsService){
        self.nycSchoolsService = nycSchoolsService
    }
    
    func setViewDelegate (schoolsListViewDelegate : SchoolsListViewDelegate){
        self.schoolsListViewDelegate = schoolsListViewDelegate
    }
    
    func getSchoolsList(){
        nycSchoolsService.getSchoolsData() {response in
            self.schools = response
            self.schoolDisplayable = response
            self.schoolsListViewDelegate?.onUpdateSchoolsList(schools: response)
            self.getSatStats()
        }
    }
    
    func getSatStats(){
        nycSchoolsService.getSatScoreStats() {response in
            self.satStats = response
        }
    }
    
    func getUpdatedSchoolData(school : School) -> School{
        var updatedSchool = school;
        if let row = self.satStats.firstIndex(where: {$0.dbn == school.dbn}) {
            updatedSchool.updateSatStats(satStats: self.satStats[row])
        }
        return updatedSchool
    }
    
    func searchFor(searchString : String) {
        let filteredList = schools.filter {
            $0.schoolName.localizedCaseInsensitiveContains(searchString)
        }
        self.schoolsListViewDelegate?.onUpdateSchoolsList(schools: filteredList)
    }
    
    func reloadSchoolData(){
        self.schoolsListViewDelegate?.onUpdateSchoolsList(schools: schools)
    }
}
