//
//  SchoolDetailViewController.swift
//  20210730-ArvindChellapondy-NYCSchools
//
//  Created by Arvind Chellapondy on 7/31/21.
//

import Foundation
import UIKit
import MapKit

//schools detail view controller
class SchoolDetailViewController : UITableViewController, SchoolDetailViewDelegate {
    
    
    @IBOutlet weak var mapView: MKMapView!
    
    private let schoolDetailPresenter = SchoolDetailPresenter()
    
    var data: Displayable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
    }
    
    private func commonInit(){
        guard let data = data else { return }
        schoolDetailPresenter.setViewDelegate(schoolDetailViewDelegate: self)
        schoolDetailPresenter.setData(school: data as! School)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data?.listItems.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: "detailReusableCell", for: indexPath) as! SchoolDetailTableViewCell
        cell.ItemTitleLabel?.text = data?.listItems[indexPath.row].label
        cell.ItemDescriptionLabel?.text = data?.listItems[indexPath.row].value
      return cell
    }
    
    func setPinUsingMKPlacemark(location: CLLocationCoordinate2D) {
       let pin = MKPlacemark(coordinate: location)
       let coordinateRegion = MKCoordinateRegion(center: pin.coordinate, latitudinalMeters: 300, longitudinalMeters: 300)
       mapView.setRegion(coordinateRegion, animated: true)
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = " "
        mapView.addAnnotation(annotation)
        mapView.addAnnotation(pin)
    }
    
    func onUpdateNavbarTitle(title: String) {
        self.navigationItem.title = title;
    }
    
    func onUpdateMapLocation(lat: Double, lon: Double) {
        let locCoords = CLLocationCoordinate2DMake(lat,lon)
        setPinUsingMKPlacemark(location: locCoords)
    }
    
    func onUpdateSchoolDetail(displayable : Displayable) {
        self.data = displayable
        self.tableView.reloadData()
    }
    
}

 //MARK: - SchoolDetailTableViewCell
class SchoolDetailTableViewCell : UITableViewCell {

    @IBOutlet weak var ItemTitleLabel: UILabel!
    @IBOutlet weak var ItemDescriptionLabel: UILabel!
    
}
