//
//  ViewController.swift
//  20210730-ArvindChellapondy-NYCSchools
//
//  Created by Arvind Chellapondy on 7/30/21.
//

import UIKit

//schools list view controller
class ViewController: UITableViewController, SchoolsListViewDelegate {

    private let schoolsListPresenter = SchoolsListPresenter(nycSchoolsService: NycSchoolsService())
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var items: [School] = []
    var selectedItem: School?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        searchBar.showsCancelButton = true
        schoolsListPresenter.setViewDelegate(schoolsListViewDelegate: self)
        schoolsListPresenter.getSchoolsList()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: "dataCell", for: indexPath)
      let item = items[indexPath.row]
        cell.textLabel?.text = item.schoolName
      return cell
    }
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
      selectedItem = items[indexPath.row]
      return indexPath
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      guard let destinationVC = segue.destination as? SchoolDetailViewController else {
        return
      }
        let school = schoolsListPresenter.getUpdatedSchoolData(school: selectedItem!)
        destinationVC.data = school
    }
    
    func onUpdateSchoolsList(schools: [School]) {
        self.items = schools
        self.tableView.reloadData()
        self.activityIndicator.isHidden = true
    }
    
}

// MARK: - UISearchBarDelegate
extension ViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let schoolName = searchBar.text else { return }
        schoolsListPresenter.searchFor(searchString: schoolName)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = nil
        searchBar.resignFirstResponder()
        schoolsListPresenter.reloadSchoolData()
    }
    

}

