//
//  SchoolDetailPresenter.swift
//  20210730-ArvindChellapondy-NYCSchools
//
//  Created by Arvind Chellapondy on 8/1/21.
//

import Foundation

//school detail view delegate
protocol SchoolDetailViewDelegate : NSObjectProtocol {
    
    func onUpdateNavbarTitle(title : String)
    func onUpdateMapLocation(lat : Double, lon : Double)
    func onUpdateSchoolDetail(displayable : Displayable)
}

//school detail presenter
class SchoolDetailPresenter {
    
    weak private var schoolDetailViewDelegate : SchoolDetailViewDelegate?

    var school : School?
    var schoolDisplayable : Displayable?
    
    init(){}
    
    func  setViewDelegate(schoolDetailViewDelegate: SchoolDetailViewDelegate){
        self.schoolDetailViewDelegate = schoolDetailViewDelegate
    }
    
    func setData(school : School){
        self.school = school
        self.schoolDisplayable = school
        
        updateNavBarTitle()
        updateMapLocation()
        updateSchoolDetail()
    }
    
    func updateNavBarTitle(){
        schoolDetailViewDelegate?.onUpdateNavbarTitle(title: school?.schoolName ?? "")
    }
    
    func updateMapLocation(){
        var dLat = 0.0
        var dLon = 0.0
        
        if let lat = school?.latitude, let doubleLat = Double(lat) {
          dLat = doubleLat
        }
        if let lon = school?.longitude, let doubleLon = Double(lon) {
          dLon = doubleLon
        }
        
        schoolDetailViewDelegate?.onUpdateMapLocation(lat: dLat, lon: dLon)
        
    }
    
    func updateSchoolDetail(){
        schoolDetailViewDelegate?.onUpdateSchoolDetail(displayable: schoolDisplayable!)
    }
    
}
