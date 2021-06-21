import Foundation

protocol DeckBaseCompatible: Codable {
    var cards: [Card] {get set}
    var type: DeckType {get}
    var total: Int {get}
    var trump: Suit? {get}
}

enum DeckType:Int, CaseIterable, Codable {
    case deck36 = 36
}

struct Deck: DeckBaseCompatible {

    //MARK: - Properties

    var cards = [Card]()
    var type: DeckType
    var trump: Suit?

    var total:Int {
        return type.rawValue
    }
}

extension Deck {

    init(with type: DeckType) {
        self.type = type
        cards = createDeck(suits: Suit.allCases, values: Value.allCases)
    }

    public func createDeck(suits:[Suit], values:[Value]) -> [Card] {
        var cards:[Card] = []
        for suit in suits {
            for value in values {
                let card = Card(suit: suit, value: value, isTrump: false)
                cards.append(card)
            }
        }
        return cards
    }

    public mutating func shuffle() {
        cards.shuffle()
    }

    public mutating func defineTrump() {
        trump = cards.last?.suit
        setTrumpCards(for: trump!)
    }

    public mutating func initialCardsDealForPlayers(players: [Player]) {
        var arrayCards = [Card]()

        players.forEach { hands in
            var index = 0
            while index < 6 {
                arrayCards.append(cards[0])
                cards.remove(at: 0)
                index += 1
            }
            hands.hand = arrayCards
        }
    }

    public mutating func setTrumpCards(for suit:Suit) {
        cards = cards.map {Card(suit: $0.suit, value: $0.value, isTrump: $0.suit == suit)}
    }
}

