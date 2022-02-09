import Combine
import Foundation

final class Model {
    let subjectX = PassthroughSubject<String, Never>()
    let subjectY = PassthroughSubject<String, Never>()
}

let model = Model()

final class ViewModel {
    var text: String = "" {
        didSet {
            print("didSet text:", text)
        }
    }
}

final class Receiver {
    var subscriptions = Set<AnyCancellable>()
    let viewModel = ViewModel()

    init() {
        model.subjectX
            .combineLatest(model.subjectY)
            .map { valueX, valueY in
                "X: \(valueX), Y: \(valueY)"
            }
            .assign(to: \.text, on: viewModel)
            .store(in: &subscriptions)
    }
}

let receiver = Receiver()
model.subjectX.send("1")
model.subjectX.send("2")
model.subjectY.send("3")
model.subjectY.send("4")
model.subjectX.send("5")

/*
 didSet text: X: 2, Y: 3
 didSet text: X: 2, Y: 4
 didSet text: X: 5, Y: 4
 */
