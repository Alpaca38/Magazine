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
    var selectedAction: Int = 3
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureMapView()
        configureNaviBarButton()
    }
    
    func configureNaviBarButton() {
        let filter = UIBarButtonItem(title: "filter", style: .plain, target: self, action: #selector(filterButtonTapped))
        navigationItem.rightBarButtonItem = filter
    }
    
    @objc func filterButtonTapped() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let megabox = UIAlertAction(title: "메가박스", style: .default)
        let lotte = UIAlertAction(title: "롯데시네마", style: .default)
        let cgv = UIAlertAction(title: "CGV", style: .default)
        let total = UIAlertAction(title: "전체보기", style: .default)
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        
        alert.addActions(actions: [megabox, lotte, cgv, total, cancel])
        
        present(alert, animated: true)
    }
    
    func configureMapView() {
        mapView.delegate = self
        
        let center = CLLocationCoordinate2D(latitude: 37.51798, longitude: 126.88655)

        mapView.region = MKCoordinateRegion(
            center: center, latitudinalMeters: 1000, longitudinalMeters: 1000
        )
        
        var annotations: [MKAnnotation] = []
        
        list.forEach {
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: $0.latitude , longitude: $0.longitude)
            annotation.title = $0.name
            annotations.append(annotation)
        }
        
        mapView.addAnnotations(annotations)
        
    }

}

extension MapViewController: MKMapViewDelegate {
    
}
