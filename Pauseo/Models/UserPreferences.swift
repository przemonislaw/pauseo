import Foundation

enum NicotineType: String, CaseIterable, Codable {
    case cigarettes = "Papierosy"
    case vape = "Vape"
    case nicotine = "Nikotyna"
    case mixed = "Mieszane"
    case preferNotToSay = "Wolę nie podawać"
}

enum GoalMode: String, CaseIterable, Codable {
    case quitNow = "Rzucam teraz"
    case reduce = "Ograniczam"
    case preparing = "Przygotowuję się"
    case notSure = "Jeszcze nie wiem"
}

enum TriggerCategory: String, CaseIterable, Codable {
    case stress = "Stres"
    case boredom = "Nuda"
    case alcohol = "Alkohol"
    case afterMeal = "Po jedzeniu"
    case morning = "Rano"
    case work = "Praca"
    case driving = "Jazda autem"
    case emotions = "Emocje"
    case social = "Towarzystwo"
    case other = "Inne"
}

struct UserPreferences: Codable {
    var nicotineType: NicotineType?
    var goalMode: GoalMode?
    var initialTrigger: TriggerCategory?
    var remindersEnabled: Bool = false
    var personalReason: String = ""
}
