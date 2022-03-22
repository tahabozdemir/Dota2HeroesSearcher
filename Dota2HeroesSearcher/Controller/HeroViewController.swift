//  HeroViewController.swift
import UIKit

class HeroViewController: UIViewController {
    @IBOutlet weak var heroNameLabel: UILabel!
    @IBOutlet weak var HeroInfoTableView: UITableView!
    @IBOutlet weak var heroImage: UIImageView!
    var hero:HeroData?
    override func viewDidLoad() {
        super.viewDidLoad()
        HeroInfoTableView.delegate = self
        HeroInfoTableView.dataSource = self
        heroNameLabel.text = hero?.localized_name
        let urlString = "https://api.opendota.com"+(hero?.img)!
        let url = URL(string: urlString)
        heroImage.downloaded(from: url!)
    }
    lazy var attackType = "Attack Type: \((hero?.attack_type)!)"
    lazy var baseHealthRegen = "Health Regeneration: \((hero?.base_health_regen)!)"
    lazy var baseManaRegen = "Mana Regeneration: \((hero?.base_mana_regen)!)"
    lazy var baseArmor = "Armor: \((hero?.base_armor)!)"
    lazy var baseAttackMin = "Attack: \((hero?.base_attack_min)!)"
    lazy var baseAttackMax = "Max Attack: \((hero?.base_attack_max)!)"
    lazy var baseStrength = "Strength: \((hero?.base_str)!)"
    lazy var baseAgility = "Agility: \((hero?.base_agi)!)"
    lazy var baseIntelligence = "Intelligence: \((hero?.base_int)!)"
    lazy var baseAttackRange = "Attack Range: \((hero?.attack_range)!)"
    lazy var baseAttackRate = "Attack Rate: \((hero?.attack_rate)!)"
    lazy var moveSpeed = "Move Speed: \((hero?.move_speed)!)"
    lazy var heroInfos = [attackType,baseHealthRegen,baseManaRegen,baseArmor,baseAttackMin,baseAttackMax,baseStrength,baseAgility,baseIntelligence,baseAttackRange,baseAttackRate,moveSpeed]
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

