//  ViewController.swift
import UIKit
class ViewController: UIViewController {
    @IBOutlet weak var HeroTableView: UITableView!
    @IBOutlet weak var searchHero: UISearchBar!
    @IBAction func hideKeyboard(_ sender: UITapGestureRecognizer) {
        self.searchHero.resignFirstResponder()
    }
    var heroManager = HeroManager()
    var heroes = [HeroData]()
    var filteredHeroes = [HeroData]()
    override func viewDidLoad() {
        super.viewDidLoad()
        HeroTableView.dataSource = self
        HeroTableView.delegate = self
        searchHero.delegate = self
        heroManager.delegate = self
        heroManager.getHeroes {
            self.HeroTableView.reloadData()
        }
    }
}
 // MARK: - HeroManagerDelegate
extension ViewController:HeroManagerDelegate{
    func didUpdateHero(heroes: [HeroData]){
        self.heroes = heroes
        filteredHeroes = heroes
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}
// MARK: - UITableViewDataSource - UITableViewDelegate
extension ViewController:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredHeroes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = HeroTableView.dequeueReusableCell(withIdentifier: "heroCell") as! HeroTableViewCell
        let urlString = "https://api.opendota.com"+(filteredHeroes[indexPath.row].icon)
        let url = URL(string: urlString)
        cell.heroNameLabel.text = filteredHeroes[indexPath.row].localized_name.capitalized
        cell.heroIcon.downloaded(from: url!)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetail" , sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? HeroViewController{
            destination.hero = filteredHeroes[(HeroTableView.indexPathForSelectedRow?.row)!]
        }
        
    }
}
// MARK: - UISearchBarDelegate
extension ViewController:UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredHeroes = searchText.isEmpty ? heroes: heroes.filter { $0.localized_name.contains(searchText) }
        self.HeroTableView.keyboardDismissMode = .onDrag
        HeroTableView.reloadData()
    }
}
// MARK: - UIImageView
extension UIImageView {
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
            else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}
