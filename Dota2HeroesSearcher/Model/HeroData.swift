//  HeroData.swift
import Foundation
struct HeroData: Decodable{
    let localized_name: String
    let attack_type: String
    let img: String
    let icon:String
    let base_health_regen: Float
    let base_mana_regen:Float
    let base_armor:Float
    let base_attack_min:Int
    let base_attack_max:Int
    let base_str: Int
    let base_agi:Int
    let base_int:Int
    let attack_range:Int
    let attack_rate:Float
    let move_speed:Int
}
