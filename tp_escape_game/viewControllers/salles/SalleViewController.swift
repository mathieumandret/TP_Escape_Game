import UIKit

class SalleViewController : UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    private var salle: Salle?

    /*
    On utilise un tableau de tuple plutot qu'un dictionnaire parce qu'on ne peut pas
    recupérer les clés d'un dictionnaire dans l'ordre et qu'on veut pouvoir récupérer la valeur
    et le nom d'un difficulté à partir de l'index selectionné dans le picker
    */
    private let difficultes = [
        ("Facile", Difficulte.FACILE),
        ("Intermédiaire", Difficulte.INTERMEDIAIRE),
        ("Difficile", Difficulte.DIFFICILE)
    ]

    @IBOutlet weak var nomTf: UITextField!
    @IBOutlet weak var pitchTv: UITextView!
    @IBOutlet weak var difficultePv: UIPickerView!

    func getCurrent() -> Salle? {
        return self.salle
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.difficultePv.delegate = self
        self.difficultePv.dataSource = self
        if let currentSalle = self.salle {
            self.nomTf.text = currentSalle.nom
            self.pitchTv.text = currentSalle.pitch
            self.difficultePv.selectRow(currentSalle.difficulte.rawValue, inComponent: 0, animated: false)
        }
    }

    func set(salle: Salle) {
        self.salle = salle
    }

    private func update(salle: Salle) -> Salle {
        salle.nom = self.nomTf.text!
        salle.pitch = self.pitchTv.text!
        let selectedIndex = self.difficultePv.selectedRow(inComponent: 0)
        salle.difficulte = self.difficultes[selectedIndex].1
        return salle
    }


    func getNewSalle() -> Salle {
        return self.update(salle: Salle())
    }

    func updateSalle() {
        self.salle = self.update(salle: self.salle!)
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.difficultes.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
         return self.difficultes[row].0
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
}
