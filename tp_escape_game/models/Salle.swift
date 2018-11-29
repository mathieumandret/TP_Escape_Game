enum Difficulte: Int {
    case FACILE = 0
    case INTERMEDIAIRE = 1
    case DIFFICILE = 2
}

class Salle {
    var nom: String
    var pitch: String
    var difficulte: Difficulte
    
    init(nom: String, pitch: String, difficulte: Difficulte) {
        self.nom = nom
        self.pitch = pitch
        self.difficulte = difficulte
    }

    init() {
        self.nom = ""
        self.pitch = ""
        self.difficulte = .FACILE
    }

}
