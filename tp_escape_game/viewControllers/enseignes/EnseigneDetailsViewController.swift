import UIKit

class EnseigneDetailsViewController: UIViewController, UITableViewDataSource {

    private var currentEnseigne: Enseigne?
    private var salles: [Salle] = []

    @IBOutlet weak var nameTf: UITextField!
    @IBOutlet weak var posXTf: UITextField!
    @IBOutlet weak var posYTf: UITextField!
    @IBOutlet weak var villeTf: UITextField!
    @IBOutlet weak var descTv: UITextView!
    @IBOutlet weak var sallesTable: UITableView!

    @IBAction func onMapClick(_ sender: Any) {
    }

    func setCurrent(enseigne: Enseigne) {
        self.currentEnseigne = enseigne
    }

    func getCurrent() -> Enseigne? {
        return self.currentEnseigne
    }

    override func viewDidLoad() {
        self.sallesTable.dataSource = self
        if let current = self.currentEnseigne {
            self.nameTf.text = current.nom
            self.posXTf.text = "\(current.lieu.latitude)"
            self.posYTf.text = "\(current.lieu.longitude)"
            self.villeTf.text = current.ville
            self.descTv.text = current.desc
            self.salles = current.salles
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.salles.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TitleCell", for: indexPath)
        let salle = self.salles[indexPath.row]
        cell.textLabel?.text = salle.nom
        return cell
    }

    /*
    Vérifie que tous les champs du formulaires soient valides
    */
    private func isValid() -> Bool {
        if let nom = self.nameTf.text,
           let description = self.descTv.text,
           let ville = self.villeTf.text,
           let posX = self.posXTf.text,
           let posY = self.posYTf.text {
            let fields = [nom, description, ville, posX, posY]
            return fields
                    .map({ String($0).count })
                    .filter({ $0 > 0 })
                    .count == fields.count
        }
        return false
    }


    private func update(enseigne: Enseigne) -> Enseigne? {
        if (self.isValid()) {
            enseigne.nom = self.nameTf.text!
            enseigne.desc = self.descTv.text!
            enseigne.lieu = Coordinates(latitude: Double(self.posXTf.text!)!, longitude: Double(self.posYTf.text!)!)
            enseigne.ville = self.villeTf.text!
            enseigne.salles = self.salles
            return enseigne
        }
        return nil
    }

    func updateExistingEnseigne() {
        self.currentEnseigne = self.update(enseigne: self.currentEnseigne!) ?? self.currentEnseigne
    }

    func getNewEnseigne() -> Enseigne? {
        return self.update(enseigne: Enseigne())
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let id = segue.identifier else {
            return
        }
        switch id {
        case "showSalleDetails":
            self.prepareForSalleDetails(destination: segue.destination as? SalleViewController)
            break
        case "showPOI":
            self.prepareForMap(destination: segue.destination as? MapViewController)
            break
        default:
            return

        }
    }

    private func prepareForSalleDetails(destination: SalleViewController?) {
        guard let index = self.sallesTable.indexPathForSelectedRow?.row, let dest = destination else {
            return
        }
        dest.set(salle: self.salles[index])
    }

    private func prepareForMap(destination: MapViewController?) {
        guard let enseigne = self.currentEnseigne, let dest = destination else {
            return
        }
        dest.setInitialLocation(coords: enseigne.lieu)
    }

    @IBAction func unwindEnseigneDetails(segue: UIStoryboardSegue) {
        if let source = segue.source as? SalleViewController {
            if (source.getCurrent() != nil) {
                source.updateSalle()
            } else {
                self.salles.append(source.getNewSalle())
            }
            self.sallesTable.reloadData()
        }
    }
}
