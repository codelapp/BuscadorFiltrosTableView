import UIKit
struct Personas {
    let nombre : String
    let genero : String
}
class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
   
    
    @IBOutlet weak var tabla: UITableView!
    @IBOutlet weak var search: UISearchBar!
    
    var personasDatos = [Personas]() // trae la base de datos
    var personasCeldaFiltro = [Personas]() // mostrar en las celdas y hacer el filtro
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let val1 = Personas(nombre: "Pedro", genero: "hombre")
        personasDatos.append(val1)
        let val2 = Personas(nombre: "Javier", genero: "hombre")
        personasDatos.append(val2)
        let val3 = Personas(nombre: "Daniela", genero: "mujer")
        personasDatos.append(val3)
        let val4 = Personas(nombre: "Sergio", genero: "hombre")
        personasDatos.append(val4)
        let val5 = Personas(nombre: "sonia", genero: "mujer")
        personasDatos.append(val5)
        let val6 = Personas(nombre: "Maria", genero: "mujer")
        personasDatos.append(val6)
        personasCeldaFiltro = personasDatos
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return personasCeldaFiltro.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tabla.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let persona = personasCeldaFiltro[indexPath.row]
        cell.textLabel?.text = persona.nombre
        cell.detailTextLabel?.text = persona.genero
        return cell
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        personasCeldaFiltro = personasDatos.filter({ (persona) -> Bool in
            switch search.selectedScopeButtonIndex {
            case 0:
                if searchText.isEmpty {return true}
                return persona.nombre.lowercased().contains(searchText.lowercased())
            case 1:
                if searchText.isEmpty {return persona.genero == "mujer"}
                return persona.nombre.lowercased().contains(searchText.lowercased()) && persona.genero == "mujer"
            case 2:
                if searchText.isEmpty {return persona.genero == "hombre"}
                return persona.nombre.lowercased().contains(searchText.lowercased()) && persona.genero == "hombre"
            default:
                return false
            }
        })
        
        DispatchQueue.main.async {
            self.tabla.reloadData()
        }
        
        
        /*
        guard !searchText.isEmpty else {
            personasCeldaFiltro = personasDatos
            DispatchQueue.main.async {
                self.tabla.reloadData()
            }
            return
        }
        
        personasCeldaFiltro = personasDatos.filter({ (persona) -> Bool in
            persona.nombre.lowercased().contains(searchText.lowercased())
        })
        DispatchQueue.main.async {
            self.tabla.reloadData()
        }
 */
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        switch selectedScope {
        case 0:
            personasCeldaFiltro = personasDatos
        case 1:
            personasCeldaFiltro = personasDatos.filter({ (persona) -> Bool in
                persona.genero == "mujer"
            })
        case 2:
            personasCeldaFiltro = personasDatos.filter({ (persona) -> Bool in
                persona.genero == "hombre"
            })
        default:
            print("nada mas")
        }
        DispatchQueue.main.async {
            self.tabla.reloadData()
        }
    }


}

