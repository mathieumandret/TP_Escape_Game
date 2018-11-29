class EnseigneRepository {
    
    public static let instance = EnseigneRepository()
    private var enseignes: [Enseigne]
    
    private init() {
        self.enseignes = [
            Enseigne(
                nom: "Challenge the room",
                description: "Incroyable escape game castrais",
                lieu: (43.588556, 2.213528),
                ville: "Castres",
                salles: [
                    Salle(nom: "La légende du Samuraï", pitch: "J'en sais rien", difficulte: Difficulte.FACILE),
                    Salle(nom: "L'esprit du Bayou", pitch: "Je sais pas non plus", difficulte: Difficulte.INTERMEDIAIRE)
                ]
            )
        ]
    }
    
    func getAll() -> [Enseigne] {
        return self.enseignes
    }
    
    func add(enseigne: Enseigne) {
        self.enseignes.append(enseigne)
    }
}
