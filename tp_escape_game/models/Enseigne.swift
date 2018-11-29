import Foundation

class Enseigne : NSObject, Codable {
     var nom: String
     var desc: String
     var lieu: Coordinates
     var ville: String
     var salles: [Salle]

    init(nom: String, desc: String, lieu: Coordinates, ville: String, salles: [Salle]) {
        self.nom = nom
        self.desc = desc
        self.lieu = lieu
        self.ville = ville
        self.salles = salles
    }

    override init() {
        self.nom = ""
        self.desc = ""
        self.lieu = Coordinates(latitude: 0, longitude: 0)
        self.ville = ""
        self.salles = []
        super.init()
    }
    
    func getNbSalles() -> Int {
        return self.salles.count
    }
}
