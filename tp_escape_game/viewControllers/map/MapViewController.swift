import UIKit
import MapKit


class MapViewController: UIViewController {

    private var initialLocation = CLLocation(latitude: 43.588556, longitude: 2.213528)
    private let radius: CLLocationDistance = 1000
    private var enseignes: [Enseigne] = []

    @IBOutlet weak var mapView: MKMapView!

    private func setLocation(location: CLLocation) {
        let coords = MKCoordinateRegionMakeWithDistance(location.coordinate, self.radius, self.radius)
        self.mapView.setRegion(coords, animated: true)
    }

    override func viewDidLoad() {
        self.enseignes = EnseigneRepository.instance.getAll()
        self.setLocation(location: self.initialLocation)
        self.showPOIs()
    }

    private func showPOIs() {
        enseignes
                .map({ EnseigneAnnotation(enseigne: $0) })
                .forEach({ self.mapView.addAnnotation($0) })
    }

    func setInitialLocation(coords: Coordinates) {
        self.initialLocation = CLLocation(latitude: coords.latitude, longitude: coords.longitude)
    }
}

