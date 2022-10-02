//  HeroViewController.swift
import UIKit

class HeroViewController: UIViewController {
    @IBOutlet weak var heroNameLabel: UILabel!
    @IBOutlet weak var HeroInfoTableView: UITableView!
    @IBOutlet weak var heroImage: UIImageView!
    var hero:HeroData?{
        didSet{
            guard let unwrappedHero = hero else {return}
            let attackType = "Attack Type: \(unwrappedHero.attack_type)"
            let baseHealthRegen = "Health Regeneration: \(unwrappedHero.base_health_regen)"
            let baseManaRegen = "Mana Regeneration: \(unwrappedHero.base_mana_regen)"
            let baseArmor = "Armor: \(unwrappedHero.base_armor)"
            let baseAttackMin = "Attack: \(unwrappedHero.base_attack_min)"
            let baseAttackMax = "Max Attack: \(unwrappedHero.base_attack_max)"
            let baseStrength = "Strength: \(unwrappedHero.base_str)"
            let baseAgility = "Agility: \(unwrappedHero.base_agi)"
            let baseIntelligence = "Intelligence: \(unwrappedHero.base_int)"
            let baseAttackRange = "Attack Range: \(unwrappedHero.attack_range)"
            let baseAttackRate = "Attack Rate: \(unwrappedHero.attack_rate)"
            let moveSpeed = "Move Speed: \(unwrappedHero.move_speed)"
            let heroInfo = [attackType,baseHealthRegen,baseManaRegen,baseArmor,baseAttackMin,baseAttackMax,baseStrength,baseAgility,baseIntelligence,baseAttackRange,baseAttackRate,moveSpeed]
            heroInfos.append(contentsOf: heroInfo)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        HeroInfoTableView.delegate = self
        HeroInfoTableView.dataSource = self
        heroNameLabel.text = hero?.localized_name
        let urlString = "https://api.opendota.com"+(hero?.img)!
        let url = URL(string: urlString)
        heroImage.downloaded(from: url!)
    }
    var heroInfos:[String] = []
}
// MARK: - UITableViewDelegate - UITableViewDataSource
extension HeroViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        heroInfos.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = HeroInfoTableView.dequeueReusableCell(withIdentifier: "heroInfoCell") as! HeroInfoTableViewCell
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        cell.heroInfoLabel.text = heroInfos[indexPath.row]
        cell.heroInfoImage.image = UIImage(systemName:"circle.fill")
        return cell
    }
}

