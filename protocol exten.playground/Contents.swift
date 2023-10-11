
class SuperEnemy {
    let name: String
    var hitPoints: Int
    
    init(name: String, hitPoints: Int) {
        self.name = name
        self.hitPoints = hitPoints
    }
}

protocol Superhero {
    var name: String { get }
    var alias: String { get }
    var isEvil: Bool { get }
    var superPowers: [String: Int] { get }
    
    func attack(target: SuperEnemy) -> Int
    mutating func performSuperPower(target: SuperEnemy) -> Int
}


extension Superhero {
    func printInformation() {
        print("Superhero Name: \(name)")
        print("Superhero Alias: \(alias)")
        print("Is Evil: \(isEvil ? "Yes" : "No")")
        print("Remaining Superpowers:")
        for (power, damage) in superPowers {
            print("\(power): \(damage)")
        }
    }
}



struct SpiderMan: Superhero {
    var name: String

    var alias: String

    var isEvil: Bool

    var superPowers: [String : Int]

    func attack(target: SuperEnemy) -> Int {
        let damage = Int.random(in: 20...40)
        let remainigLife = target.hitPoints - damage

        return remainigLife
    }

    mutating func performSuperPower(target: SuperEnemy) -> Int {
        let keys = Array(superPowers.keys)

        if keys.isEmpty {
            print("No superpowers remaining")
            return target.hitPoints
        }

        let randomIndex = Int.random(in: 0..<keys.count)
        let randomKey = keys[randomIndex]
        let damage = superPowers[randomKey] ?? 0

        target.hitPoints -= damage
        superPowers.removeValue(forKey: randomKey)

        return target.hitPoints
    }

}


class SuperheroSquad<T: Superhero> {
    var superheroes: [T]
    
    init(superheroes: [T]) {
        self.superheroes = superheroes
    }
    
    func listSuperheroes() {
        for hero in superheroes {
            hero.printInformation()
        }
    }
}



func simulateShowdown(squad: SuperheroSquad<SpiderMan>, enemy: SuperEnemy) {
    var superPowersRemaining = true
    
    while enemy.hitPoints > 0 && superPowersRemaining {
        for var superhero in squad.superheroes {
            if !superPowersRemaining {
                print("\(superhero.name) has finished superpowers.")
                let remainingLife = superhero.attack(target: enemy)
                print("\(superhero.name) initiates an attack. \(enemy.name)  \(remainingLife) hit points left.")
                superPowersRemaining = false
                continue
            }
            
            if enemy.hitPoints > 0 {
                let remainingLife = superhero.performSuperPower(target: enemy)
                if enemy.hitPoints <= 0 {
                    print("\(superhero.name) defeated in battle \(enemy.name)!")
                    break
                }
                print("\(superhero.name) use a superpower. \(enemy.name) left \(remainingLife) hit points.")
            }
        }
    }
    
    if enemy.hitPoints <= 0 {
        print("Superheroes win! \(enemy.name) has been defeated.")
    } else {
        print("The enemy wins.")
    }
}


let spiderMan = SpiderMan(name: "Peter Parker", alias: "SpiderMan", isEvil: false, superPowers: ["Web Swing": 20, "Spider Sense": 40, "Web Shoot": 23])
let betman  = SpiderMan(name: "Adam West", alias: "Batman", isEvil: false, superPowers: ["Omnipotence": 34, "Flight": 24, "Bane's Venom.": 27])

let squad = SuperheroSquad(superheroes: [spiderMan, betman])

let enemy = SuperEnemy(name: "Venom", hitPoints: 100)

simulateShowdown(squad: squad, enemy: enemy)







