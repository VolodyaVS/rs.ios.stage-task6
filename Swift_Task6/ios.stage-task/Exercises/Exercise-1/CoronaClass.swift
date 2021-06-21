import Foundation

class CoronaClass {

    var seats = [Int]()
    var numberOfDesks: Int

    init(n: Int) {
        if n >= 1 && n <= 100 {
            numberOfDesks = n
        } else if n < 1 {
            numberOfDesks = 1
        } else {
            numberOfDesks = 100
        }
    }

    func seat() -> Int {
        let lastDesk = numberOfDesks-1
        var deskNumber = 0

        if seats.isEmpty {
            seats.append(0)
        } else {
            var tempNumber = 0
            switch seats.count {
            case _ where seats.last != lastDesk :
                if (lastDesk - seats.last!) > tempNumber {
                    deskNumber = lastDesk
                    seats.append(lastDesk)
                }
            default:
                for index in 0 ..< seats.count-1 {
                    let expression = ((seats[index+1] - seats[index]) / 2)
                    if expression > tempNumber {
                        tempNumber = expression
                        deskNumber = (seats[index] + tempNumber)
                    }
                }
                seats.append(deskNumber)
                seats = seats.sorted()
            }
        }
        return deskNumber
    }

    func leave(_ p: Int) {
        if let index = seats.firstIndex(of: p) {
            seats.remove(at: index)
        }
    }
}
