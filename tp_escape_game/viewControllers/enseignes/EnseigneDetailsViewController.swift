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
        print("Map click")
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
            self.posXTf.text = "\(current.lieu.0)"
            self.posYTf.text = "\(current.lieu.1)"
            self.villeTf.text = current.ville
            self.descTv.text = current.description
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

    private func update(enseigne: Enseigne) -> Enseigne {
        enseigne.nom = self.nameTf.text!
        enseigne.description = self.descTv.text!
        enseigne.lieu = (Double(self.posXTf.text!)!, Double(self.posYTf.text!)!)
        enseigne.ville = self.villeTf.text!
        enseigne.salles = self.salles
        return enseigne
    }

    func updateExistingEnseigne() {
        self.currentEnseigne = self.update(enseigne: self.currentEnseigne!)
    }

    func getNewEnseigne() -> Enseigne {
        return self.update(enseigne: Enseigne())
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let id = segue.identifier,
           let destination = segue.destination as? SalleViewController,
           let index = self.sallesTable.indexPathForSelectedRow?.row {
            if (id == "showSalleDetails") {
                destination.set(salle: self.salles[index])
            }
        }
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
