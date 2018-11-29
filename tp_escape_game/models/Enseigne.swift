class Enseigne {
     var nom: String
     var description: String
     var lieu: (Double, Double)
     var ville: String
     var salles: [Salle]

    init(nom: String, description: String, lieu: (Double, Double), ville: String, salles: [Salle]) {
        self.nom = nom
        self.description = description
        self.lieu = lieu
        self.ville = ville
        self.salles = salles
    }

    init() {
        self.nom = ""
        self.description = ""
        self.lieu = (0, 0)
        self.ville = ""
        self.salles = []
    }
    
    func getNbSalles() -> Int {
        return self.salles.count
    }
}
