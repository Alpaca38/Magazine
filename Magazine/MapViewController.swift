//
//  MapViewController.swift
//  Magazine
//
//  Created by 조규연 on 5/30/24.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    @IBOutlet var mapView: MKMapView!
    
    let list = RestaurantList.restaurantArray
    var filteredList: [Restaurant] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        filteredList = list
        
        configureMapView()
        createAnnotations()
        configureNaviBarButton()
    }
    
    func configureMapView() {
        let center = CLLocationCoordinate2D(latitude: 37.51798, longitude: 126.88655)

        mapView.region = MKCoordinateRegion(
            center: center, latitudinalMeters: 1000, longitudinalMeters: 1000
        )
    }
    
    func configureNaviBarButton() {
        let filter = UIBarButtonItem(title: "filter", style: .plain, target: self, action: #selector(filterButtonTapped))
        navigationItem.rightBarButtonItem = filter
    }
    
    @objc func filterButtonTapped() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let korea = UIAlertAction(title: "한식", style: .default) { [weak self] _ in
            guard let self else { return }
            filteredList = list.filter({ $0.category == "한식" })
            mapView.removeAnnotations(mapView.annotations)
            createAnnotations()
        }
        let japan = UIAlertAction(title: "일식", style: .default) { [weak self] _ in
            guard let self else { return }
            filteredList = list.filter({ $0.category == "일식" })
            mapView.removeAnnotations(mapView.annotations)
            createAnnotations()
        }
        let western = UIAlertAction(title: "양식", style: .default) { [weak self] _ in
            guard let self else { return }
            filteredList = list.filter({ $0.category == "양식" })
            mapView.removeAnnotations(mapView.annotations)
            createAnnotations()
        }
        let koreaWestern = UIAlertAction(title: "경양식", style: .default) { [weak self] _ in
            guard let self else { return }
            filteredList = list.filter({ $0.category == "경양식" })
            mapView.removeAnnotations(mapView.annotations)
            createAnnotations()
        }
        let bunsik = UIAlertAction(title: "분식", style: .default) { [weak self] _ in
            guard let self else { return }
            filteredList = list.filter({ $0.category == "분식" })
            mapView.removeAnnotations(mapView.annotations)
            createAnnotations()
        }
        let cafe = UIAlertAction(title: "카페", style: .default) { [weak self] _ in
            guard let self else { return }
            filteredList = list.filter({ $0.category == "카페" })
            mapView.removeAnnotations(mapView.annotations)
            createAnnotations()
        }
        let total = UIAlertAction(title: "전체보기", style: .default) { [weak self] _ in
            guard let self else { return }
            filteredList = list
            mapView.removeAnnotations(mapView.annotations)
            createAnnotations()
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        
        alert.addActions(actions: [korea, japan, western, koreaWestern, bunsik, cafe, total, cancel])
        
        present(alert, animated: true)
    }
    
    func createAnnotations() {
        var annotations: [MKAnnotation] = []
        
        filteredList.forEach {
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: $0.latitude , longitude: $0.longitude)
            annotation.title = $0.name
            annotations.append(annotation)
        }
        
        mapView.addAnnotations(annotations)
    }

}
