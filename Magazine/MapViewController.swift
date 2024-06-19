//
//  MapViewController.swift
//  Magazine
//
//  Created by 조규연 on 5/30/24.
//

import UIKit
import MapKit
import CoreLocation
import SnapKit

class MapViewController: UIViewController {

    @IBOutlet var mapView: MKMapView!
    lazy var currentLocationButton = {
        let button = UIButton()
        var configuration = UIButton.Configuration.filled()
        configuration.image = UIImage(systemName: "location.fill")
        configuration.baseBackgroundColor = .white
        configuration.baseForegroundColor = .black
        button.configuration = configuration
        button.addTarget(self, action: #selector(currentLocationButtonTapped), for: .touchUpInside)
        self.view.addSubview(button)
        return button
    }()
    
    let list = RestaurantList.restaurantArray
    var filteredList: [Restaurant] = []
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        
        filteredList = list
        
        configureMapView()
        createAnnotations()
        configureNaviBarButton()
        
        currentLocationButton.snp.makeConstraints {
            $0.top.trailing.equalTo(view.safeAreaLayoutGuide).inset(30)
            $0.size.equalTo(40)
        }
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

extension MapViewController {
    @objc func currentLocationButtonTapped() {
        let status = locationManager.authorizationStatus
        switch status {
        case .denied:
            showSettingAlert(title: "앱의 위치 권한을 설정해주세요.", message: "설정 - 개인정보 보호 및 보안 - 위치 서비스에서 앱의 위치 권한을 설정해주세요. 설정으로 이동하시겠습니까?")
        case .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
        default:
            print(status)
        }
    }
}

extension MapViewController {
    func checkDeviceLocationAuthorization() {
        DispatchQueue.global().async {
            if CLLocationManager.locationServicesEnabled() {
                self.currentLocationAuthorization()
            } else {
                DispatchQueue.main.async {
                    self.showSettingAlert(title: "아이폰 위치 서비스를 활성화해야합니다.", message: "설정 - 개인정보 보호 및 보안 - 위치 서비스를 활성화 해주세요. 설정으로 이동하시겠습니까?")
                }
            }
        }
    }
    
    func currentLocationAuthorization() {
        let status = locationManager.authorizationStatus
        
        switch status {
        case .notDetermined:
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization()
        case .denied:
            DispatchQueue.main.async {
                self.showSettingAlert(title: "앱의 위치 권한을 설정해주세요.", message: "설정 - 개인정보 보호 및 보안 - 위치 서비스에서 앱의 위치 권한을 설정해주세요. 설정으로 이동하시겠습니까?")
            }
        case .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
        default:
            print(status)
        }
    }
    
    func setRegion(center: CLLocationCoordinate2D) {
        let region = MKCoordinateRegion(center: center, latitudinalMeters: 1000, longitudinalMeters: 1000)
        mapView.setRegion(region, animated: true)
    }
    
    func showSettingAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "설정으로 이동", style: .default) { _ in
            UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        alert.addAction(ok)
        alert.addAction(cancel)
        present(alert, animated: true)
    }
}

extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let coordinate = locations.last?.coordinate {
            setRegion(center: coordinate)
        }
        locationManager.stopUpdatingLocation()
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print(error.localizedDescription)
    }
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkDeviceLocationAuthorization()
    }
}
