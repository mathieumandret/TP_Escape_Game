import MapKit

class EnseigneAnnotation: NSObject,  MKAnnotation {
    var title: String? {
        return self.enseigne.nom
    }
    var subtitle: String? {
        return "\(self.enseigne.getNbSalles()) salle(s)"
    }
    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: enseigne.lieu.latitude, longitude: enseigne.lieu.longitude)
    }

    let enseigne: Enseigne

    init(enseigne: Enseigne) {
        self.enseigne = enseigne
        super.init()
    }
}

