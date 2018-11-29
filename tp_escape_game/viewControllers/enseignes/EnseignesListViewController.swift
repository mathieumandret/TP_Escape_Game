import UIKit

class EnseignesListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var table: UITableView!

    private var enseignes = EnseigneRepository.instance.getAll()

    override func viewDidLoad() {
        self.table.delegate = self
        self.table.dataSource = self
    }

    private func updateEnseigneList() {
        self.enseignes = EnseigneRepository.instance.getAll()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.enseignes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LabelCell", for: indexPath)
        let enseigne = self.enseignes[indexPath.row]
        cell.textLabel?.text = enseigne.nom
        cell.detailTextLabel?.text = "\(enseigne.getNbSalles()) salle(s)"
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let id = segue.identifier,
           let destination = segue.destination as? EnseigneDetailsViewController,
           let index = self.table.indexPathForSelectedRow?.row {
            if (id == "showEnseigneDetails") {
                destination.setCurrent(enseigne: self.enseignes[index])
            }
        }
    }
      @IBAction func unwindToEnseigneList(segue: UIStoryboardSegue) {
          let source = segue.source as! EnseigneDetailsViewController
          if (source.getCurrent() != nil) {
              source.updateExistingEnseigne()
          } else {
              EnseigneRepository.instance.add(enseigne: source.getNewEnseigne())
              self.updateEnseigneList()
          }
          self.table.reloadData()
    }
    
    
}
