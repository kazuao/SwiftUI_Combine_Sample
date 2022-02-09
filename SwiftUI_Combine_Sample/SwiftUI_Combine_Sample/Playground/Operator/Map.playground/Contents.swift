import Combine
import Foundation

final class Model {
    @Published var value: Int = 0
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
    let formatter = NumberFormatter()

    init() {
        formatter.numberStyle = .spellOut

        model.$value
            // こうも書ける
//            .compactMap { value in
//                self.formatter.string(from: NSNumber(integerLiteral: value))
//            }
            .map { value in
                self.formatter.string(from: NSNumber(integerLiteral: value)) ?? ""
            }
            .assign(to: \.text, on: viewModel)
            .store(in: &subscriptions)
    }
}

let receiver = Receiver()
model.value = 1
model.value = 2
model.value = 3
model.value = 4
model.value = 5
