import Foundation

class EnseigneRepository {
    
    public static let instance = EnseigneRepository()
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    private let fileURL: URL?
    private var enseignes: [Enseigne] = []
    
    private init() {
        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        self.fileURL = url?.appendingPathComponent("enseignes.json")
    }
    
    func getAll() -> [Enseigne] {
        return self.enseignes
    }
    
    func add(enseigne: Enseigne) {
        self.enseignes.append(enseigne)
    }

    func persist() {
        let data = try? self.encoder.encode(self.getAll())
        if let url = self.fileURL {
            try? data?.write(to: url)
        }
    }

    func restore() {
        if let url = self.fileURL {
            let data = try? Data(contentsOf: url)
            if let d = data {
                let enseignes = try? self.decoder.decode([Enseigne].self, from: d)
                self.enseignes = enseignes ?? []
            }
        }
    }
}
